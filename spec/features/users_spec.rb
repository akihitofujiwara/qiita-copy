require "rails_helper"

feature "Users" do
  given!(:user) { create(:user) }

  background do
    login_as user, scope: :user
    visit root_path
    click_on "設定"
  end

  scenario "ユーザーを更新する" do
    fill_in "ユーザー名", with: "#{user.username}_hoge"
    expect do
      click_on "保存する"
      user.reload
    end.to change { user.username }
  end
end
