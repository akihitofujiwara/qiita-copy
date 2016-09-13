require "rails_helper"

feature "Followings" do
  given!(:user) { create :user }
  given!(:other_user) { create :user }
  given!(:item) { create :item, author: other_user }
  given!(:tag) { create(:tag).tap {|it| it.items << item } }

  background do
    login_as user, scope: :user
    visit root_path
    click_on "すべての投稿"
    click_on item.title
  end

  scenario "タグをフォローする" do
    click_on tag.name
    expect do
      click_on "フォロー"
    end.to change { user.followee_tags.count }.by(1)
  end

  context "タグをフォロー済み" do
    background do
      user.followee_tags << tag
      visit current_path
    end

    scenario "タグをフォロー解除する" do
      click_on tag.name
      expect do
        click_on "フォロー中"
      end.to change { user.followee_tags.count }.by(-1)
    end
  end

  scenario "ユーザーをフォローする" do
    click_on other_user.username
    expect do
      click_on "フォロー"
    end.to change { user.followee_users.count }.by(1)
  end

  context "ユーザーをフォロー済み" do
    background do
      user.followee_users << other_user
      visit current_path
    end

    scenario "ユーザーをフォロー解除する" do
      click_on other_user.username
      expect do
        click_on "フォロー中"
      end.to change { user.followee_users.count }.by(-1)
    end
  end
end

