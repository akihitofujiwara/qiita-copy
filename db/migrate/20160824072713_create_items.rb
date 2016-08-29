class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.text :body
      t.references :author, index: true
      t.integer :stockers_count, default: 0, null: false
      t.integer :comments_count, default: 0, null: false
      t.string :scope, null: false
      t.timestamps
    end
  end
end
