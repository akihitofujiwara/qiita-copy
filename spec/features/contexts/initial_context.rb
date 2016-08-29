shared_context "initial_context" do
  let! (:user) { User.create email: "hoge@hoge.com", password: "hogehoge" }
  let! (:other_user) { User.create email: "fuga@fuga.com", password: "fugafuga" }
  let! (:public_item) { user.items.create title: "First item", tag_list: "ls stylus", body: "hey", scope: "public" }
  let! (:private_item) { user.items.create title: "Second item", tag_list: "ls jade", body: "hoy", scope: "private" }
  let! (:other_item) { other_user.items.create title: "Other first item", tag_list: "slim ls", body: "hi", scope: "public" }
  let! (:comment) { public_item.comments.create body: "Like!", commenter: user }
  let! (:tag) { public_item.tags.first }
  background {
    user.stock other_item
  }
end
