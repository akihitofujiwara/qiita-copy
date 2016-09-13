require 'rails_helper'

feature "Home" do
  given!(:user) { create(:user) }

  background do
    visit root_path
  end

  scenario "ログイン" do
    within ".login" do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_on "ログイン"
    end
    expect(page).to have_content("ログアウト")
  end

  scenario "Twitterでログイン" do
    create(:user, provider: :twitter, uid: OmniAuth.config.mock_auth[:twitter].uid )
    click_on "Twitterで新規登録/ログイン"
    expect(page).to have_content("ログアウト")
  end

  scenario "メールアドレスで登録" do
    within ".signup" do
      fill_in "user_username", with: "username"
      fill_in "user_email", with: "email@email.com"
      fill_in "user_password", with: "password"
      expect { click_on "登録" }.to change { User.count }
    end
  end

  scenario "Twitterで登録" do
    click_on "Twitterで新規登録/ログイン"
    fill_in "user_email", with: "email@email.com"
    expect { click_on "登録" }.to change { User.count }
  end
end

