class AddSearchDateIdToSummaries < ActiveRecord::Migration
  def change
		add_column :summaries, :search_date_id, :integer
  end
end
