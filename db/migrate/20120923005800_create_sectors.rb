class CreatePlanets < ActiveRecord::Migration
  def up
        create_table :planets do |t|
          t.integer :x
          t.integer :y
          t.string :type
          t.string :name
  end
  def down
     drop_table :sectors
  end
  end
end
