class DropCityFromCitiToToSummaries < ActiveRecord::Migration
  def up
		remove_column :summaries, :city_from
		remove_column :summaries, :city_to
  end

  def down
		add_column :summaries, :city_from, :integer
		add_column :summaries, :city_to, :integer		
  end
end
