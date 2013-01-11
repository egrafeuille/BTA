class AddKeyToAirlines < ActiveRecord::Migration
  def change
    add_column :airlines, :key, :string
  end
end
