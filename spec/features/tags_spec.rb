require 'rails_helper'
require 'features/contexts/initial_context'

feature "Tags" do
  include_context "initial_context"

  feature "show" do
    background {
      login_as user, scope: :user
      visit tag_path(tag)
    }

    scenario "show" do
      expect(page).to have_content tag.name
      expect(page).to have_content "#{tag.followers.count} #{"follower".pluralize(tag.followers.count)}"
      expect(page).to have_content "#{tag.items.count} tagged #{"item".pluralize(tag.items.count)}"
      expect(page).to have_content user.items.first.title
      expect(page).to have_selector ".recent-stocked-items", text: tag.items.recent_stocked.first.title
      expect(page).to have_selector ".recent-items", text: tag.items.first.title
    end
  end

  feature "follow, unfollow" do
    background {
      login_as user, scope: :user
      visit tag_path(tag)
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
        user.follow tag
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



