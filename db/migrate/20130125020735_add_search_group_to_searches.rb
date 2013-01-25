class AddSearchGroupToSearches < ActiveRecord::Migration
  def change
		add_column :searches, :search_group_id, :integer
  end
end
