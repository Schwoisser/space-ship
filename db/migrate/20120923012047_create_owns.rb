class CreateOwns < ActiveRecord::Migration
  def up
      create_table :owns do |t|
        t.integer :user_id
        t.string :ship
      end
  end
  def down
    drop_table :owns
  end
end
