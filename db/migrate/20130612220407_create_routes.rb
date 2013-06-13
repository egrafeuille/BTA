class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :city_from_id
      t.integer :city_to_id
      t.integer :info_priority
      t.boolean :is_active

      t.timestamps
    end
  end
end
