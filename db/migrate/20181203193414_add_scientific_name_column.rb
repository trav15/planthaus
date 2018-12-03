class AddScientificNameColumn < ActiveRecord::Migration
  def change
    add_column :plants, :scientific_name, :string
  end
end
