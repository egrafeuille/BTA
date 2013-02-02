class DropCityFromCitiToToSummaries < ActiveRecord::Migration
  def up
		remove_column :summaries, :city_from_id
		remove_column :summaries, :city_to_id
  end

  def down
		add_column :summaries, :city_from_id, :integer
		add_column :summaries, :city_to_id, :integer		
  end
end
