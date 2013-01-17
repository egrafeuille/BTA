class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.references :city_from
      t.references :city_to
      t.datetime :departure
      t.datetime :arrival
      t.string :active
      t.integer :priority

      t.timestamps
    end
    add_index :searches, :city_from_id
    add_index :searches, :city_to_id
  end
end
