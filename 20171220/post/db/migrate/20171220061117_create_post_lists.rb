class CreatePostLists < ActiveRecord::Migration
  def change
    create_table :post_lists do |t|
      t.string :title
      t.string :name
      t.text :text
      t.timestamps null: false
    end
  end
end
