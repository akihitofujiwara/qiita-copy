require "rails_helper"

feature "Stocks" do
  given!(:user) { create(:user) }
  given!(:item) { create(:item, author: user) }

  background do
    login_as user, scope: :user
    visit root_path
    click_on "自分の投稿"
    click_on item.title
  end

  scenario "記事をストックする" do
    expect do
      click_on "ストック"
      item.reload
    end.to change { item.stocks.count }.by(1)
  end

  context "ストック済み" do
    background do
      user.stocked_items << item
      visit current_path
    end

    scenario "記事をストック解除する" do
      expect do
        click_on "ストック済み"
        item.reload
      end.to change { item.stocks.count }.by(-1)
    end
  end
end

