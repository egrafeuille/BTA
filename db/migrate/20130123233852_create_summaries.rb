class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.integer :source_id
      t.integer :search_id
      t.integer :city_from_id
      t.integer :city_to_id
      t.integer :airline_id
      t.integer :stops
      t.string :currency
      t.decimal :price, :precision => 8, :scale =>2

      t.timestamps
    end
  end
end
