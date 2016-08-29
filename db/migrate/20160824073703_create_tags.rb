class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.integer :taggables_count, default: 0, null: false
      t.integer :followers_count, default: 0, null: false
      t.timestamps
    end

    add_index :tags, :name, unique: true
  end
end
