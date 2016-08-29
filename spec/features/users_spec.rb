require 'rails_helper'
require 'features/contexts/initial_context'

feature "Users" do
  include_context "initial_context"

  feature "show" do
    background {
      login_as user, scope: :user
      visit user_path(user)
    }

    scenario "show" do
      expect(page).to have_content user.email
      expect(page).to have_content "#{user.followers.count} #{"follower".pluralize(user.followers.count)}"
      expect(page).to have_content "#{user.stocked_items.count} stocked #{"item".pluralize(user.stocked_items.count)}"
      expect(page).to have_content user.items.first.title
    end

    context "me" do
      background {
        visit user_path(user)
      }

      scenario "show" do
        expect(page).not_to have_link "Follow"
      end
    end

    context "other" do
      background {
        visit user_path(other_user)
      }

      scenario "show" do
        expect(page).to have_link "Follow"
      end
    end
  end

  feature "follow, unfollow" do
    background {
      login_as user, scope: :user
      visit user_path(other_user)
    }

    context "not followed yet" do
      scenario "follow" do
        expect(page).to have_content "Follow"
        click_on "Follow"
        expect(page).to have_content "Unfollow"
      end
    end

    context "already followed" do
      background {
        user.follow other_user
        visit current_path
      }

      scenario "unfollow" do
        expect(page).to have_content "Unfollow"
        click_on "Unfollow"
        expect(page).to have_content "Follow"
      end
    end
  end
end



