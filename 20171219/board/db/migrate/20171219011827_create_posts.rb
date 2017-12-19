class CreatePosts < ActiveRecord::Migration
  def change
    create_table :post do |t|
      t.string :username
      t.string :title
      t.text :text
      t.timestamps null: false
    end
  end
end

#우리가 db를 이렇게 구성하겠다????
#설계도
