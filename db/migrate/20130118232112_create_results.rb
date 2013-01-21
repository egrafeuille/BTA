class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :search_id
      t.integer :source_id
      t.integer :airport_from_id
      t.integer :airport_to_id
      t.datetime :departure
      t.datetime :arrival
      t.integer :airline_id
      t.integer :stops
      t.string :currency
      t.decimal :price, :precision => 10, :scale => 2, :default => 0
      t.time :traveltime

      t.timestamps
    end
  end
end
