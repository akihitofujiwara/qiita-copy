require "rails_helper"

feature "Items" do
  given!(:user) { create(:user) }
  given!(:item) { create(:item, author: user) }
  given!(:comment) { create(:comment, commentable: item, commenter: user) }

  background do
    login_as user, scope: :user
    visit root_path
    click_on "自分の投稿"
    click_on item.title
  end

  scenario "コメントする" do
    fill_in "comment_body", with: "コメント"
    expect { click_on "投稿" }.to change { item.comments.count }
  end


  scenario "コメントを削除する" do
    within ".comment" do
      expect { click_on "削除" }.to change { item.comments.count }
    end
  end
end

