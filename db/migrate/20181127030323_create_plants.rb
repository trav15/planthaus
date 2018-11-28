class CreatePlants < ActiveRecord::Migration
  def change
    create_table :plants do |t|
      t.string :name
      t.string :plant_type
      t.string :water_requirement
      t.string :light_requirement
      t.string :date_purchased
      t.string :notes
      t.integer :user_id
    end
  end
end
