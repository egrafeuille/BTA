class RenameSearchesToGenericSearches < ActiveRecord::Migration
  def up
		rename_table :searches, :generic_searches
  end

  def down
				rename_table :generic_searches, :searches
  end
end
