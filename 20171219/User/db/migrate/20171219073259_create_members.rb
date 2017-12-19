class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :mem_id
      t.string :mem_name
      t.string :mem_email
      t.string :mem_pwd
      t.timestamps null: false
    end
  end
end
