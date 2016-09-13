require "rails_helper"

feature "Items" do
  given!(:user) { create(:user) }
  given!(:item) { create(:item, author: user) }
  given!(:other_item) { create(:item, author: user) }

  background do
    login_as user, scope: :user
    visit root_path
  end

  scenario "記事を投稿する" do
    click_on "投稿する"
    within("#new_item") do
      fill_in "item_title", with: "タイトル"
      fill_in "item_tag_list", with: "ruby rails"
      fill_in "item_body", with: "# こんにちは"
      expect { click_on "投稿する" }.to change { user.items.count }.by(1)
    end
    expect(user.items.last.tags.count).to eq(2)
  end

  scenario "検索する" do
    find("body > header input[type=\"search\"]").set("user:#{user.username} #{item.title}")
    click_on "検索"
    expect(page).to have_content(item.title)
      .and have_no_content(other_item.title)
  end

  context "個別記事" do
    background do
      click_on "自分の投稿"
      click_on item.title
    end

    scenario "記事を更新する" do
      within("body > .header") { click_on "編集" }
      within("body > form") do
        fill_in "item_title", with: "#{item.title} hoge"
        fill_in "item_tag_list", with: "#{item.tag_list} hoge"
        fill_in "item_body", with: "#{item.body} hoge"
        find("#item_scope", visible: false).set "private"
        expect do
          click_button "投稿する"
          item.reload
        end.to change { [item.title, item.tag_list, item.body, item.scope] }
      end
    end

    scenario "記事を削除する" do
      expect { click_on "削除" }.to change { user.items.count }.by(-1)
    end
  end
end
