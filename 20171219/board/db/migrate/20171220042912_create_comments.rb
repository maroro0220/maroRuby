class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :post_id  #이건 약속 무조건 이렇게 써줘야함. 1:n관계를 위해서?
      t.timestamps null: false
    end
  end
end
