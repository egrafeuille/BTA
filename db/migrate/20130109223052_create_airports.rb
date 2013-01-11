class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :key
      t.string :name
      t.integer :city_id
      t.integer :km_to_city

      t.timestamps
    end
  end
end
