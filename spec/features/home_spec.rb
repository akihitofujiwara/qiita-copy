require 'rails_helper'
require 'features/contexts/initial_context'

feature "Home" do
  include_context "initial_context"

  feature "root" do
    background { visit root_path }

    context "before sign in" do
      scenario "items" do
        expect(page).to have_content public_item.title
        expect(page).not_to have_content private_item.title
      end

      scenario "sign in" do
        click_on "Sign In"
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_on "Sign in"
        expect(page).to have_content "Signed in successfully."
      end
    end

    context "after sign in" do
      background {
        login_as user, scope: :user
        visit current_path
      }

      scenario "sign in" do
        expect(page).to have_content "Sign Out"
      end
    end
  end

  feature "items" do
    background {
      login_as user, scope: :user
      visit items_path
    }

    scenario "items" do
      expect(page).to have_content public_item.title
      expect(page).not_to have_content private_item.title
    end
  end

  feature "mines" do
    background {
      login_as user, scope: :user
      visit mines_path
    }

    scenario "mines" do
      expect(page).to have_content public_item.title
      expect(page).to have_content private_item.title
      expect(page).not_to have_content other_item.title
    end
  end

  feature "stocks" do
    background {
      login_as user, scope: :user
      visit stocks_path
    }

    scenario "stocks" do
      expect(page).to have_content other_item.title
      expect(page).not_to have_content public_item.title
    end
  end
end

