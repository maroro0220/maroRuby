class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.text :comm
      t.integer :user_id
      t.integer :post_list_id
      t.timestamps null: false
    end
  end
end
