class AddUsernameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :username, :string
    User.all.each { |user| user.update username: (user.email.match(/([^@]+)@/)[1]) }
    add_index :users, :username, unique: true
  end

  def down
    remove_column :users, :username
  end
end
