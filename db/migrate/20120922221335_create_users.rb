class CreateUsers < ActiveRecord::Migration
  def up
      create_table :users do |t|
        t.string :name
        t.string :password
        t.integer :password
      end
  end

  def down
     drop_table :users
  end
end
