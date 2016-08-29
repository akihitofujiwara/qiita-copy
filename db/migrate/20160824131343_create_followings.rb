class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.references :followee, polymorphic: true, index: true
      t.references :follower, index: true

      t.timestamps null: false
    end
    add_index :followings, %i(followee_id followee_type follower_id), unique: true, name: "followee_and_follower"
  end
end
