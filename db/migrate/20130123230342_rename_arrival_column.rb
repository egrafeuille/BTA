class RenameArrivalColumn < ActiveRecord::Migration
  def up
	rename_column :searches, :arrival, :return
  end

  def down
	rename_column :searches, :return, :arrival  
  end
end
