class DropDepartureAndReturnFromSearches < ActiveRecord::Migration
  def up
		remove_column :searches, :departure
		remove_column :searches, :return
		remove_column :searches, :active		
  end

  def down
		add_column :searches, :departure, :datetime
		add_column :searches, :return, :datetime
		add_column :searches, :active, :string		
  end
end
