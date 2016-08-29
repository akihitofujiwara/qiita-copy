class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :stockable, polymorphic: true, index: true
      t.references :stocker, index: true

      t.timestamps null: false
    end
    add_index :stocks, %i(stockable_id stockable_type stocker_id), unique: true
  end
end
