class CreateUsers < ActiveRecord::Migration
  def up
      create_table :users do |t|
        t.string :name
        t.string :password
        #t.string :salt
        #t.string :hashed_password
      end
  end

  def down
     drop_table :users
  end
end
