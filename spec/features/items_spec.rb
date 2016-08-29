require 'rails_helper'
require 'features/contexts/initial_context'

feature "Items" do
  include_context "initial_context"

  feature "new, create" do
    background {
      login_as user, scope: :user
      visit new_item_path
    }

    scenario "create" do
      fill_in "Title", with: "Third item"
      fill_in "Tags", with: "stylus coffee"
      fill_in "Body", with: "hello"
      click_on "Save"
      expect(page).to have_content "Item was successfully created."
    end
  end

  feature "edit, update" do
    background {
      login_as user, scope: :user
      visit edit_item_path public_item
    }

    scenario "update" do
      select "Private", from: "item_scope"
      click_on "Save"
      expect(page).to have_content "Item was successfully updated."
    end
  end

  feature "destroy" do
    background {
      login_as user, scope: :user
      visit user_item_path(user, public_item)
    }

    scenario "destroy" do
      within ".subject-actions" do
        click_on "Destroy"
      end
      expect(page).to have_content "Item was successfully destroyed."
    end
  end

  feature "show" do
    background {
      login_as user, scope: :user
      visit user_item_path(user, public_item)
    }
    scenario "show" do
      expect(page).to have_content public_item.author.email
      expect(page).to have_content public_item.tags.first.name
      expect(page).to have_content public_item.title
      expect(page).to have_content "#{public_item.stockers_count} stockers"
      expect(page).to have_content public_item.body
      expect(page).to have_content public_item.comments.first.body
    end
  end

  feature "stock, unstock" do
    background {
      login_as user, scope: :user
      visit user_item_path(other_user, other_item)
    }

    context "already stocked" do
      scenario "unstock" do
        expect(page).to have_content "Unstock"
        click_on "Unstock"
        expect(page).to have_content "Stock"
      end
    end

    context "not stocked yet" do
      background {
        user.unstock other_item
        visit current_path
      }

      scenario "stock" do
        expect(page).to have_content "Stock"
        click_on "Stock"
        expect(page).to have_content "Unstock"
      end
    end
  end

  feature "comment" do
    background {
      login_as user, scope: :user
      visit user_item_path(user, public_item)
    }

    scenario "create" do
      fill_in "Body", with: "Dislike!"
      click_on "Save"
      expect(page).to have_content "Dislike!"
    end

    scenario "destroy" do
      within ".comments" do
        click_on "Destroy"
      end
      expect(page).not_to have_content comment.body
    end
  end
end


