class RenameReturnFieldInSearchDates < ActiveRecord::Migration
  def up
    rename_column :search_dates, :return, :returndate
  end

  def down
        rename_column :search_dates, :returndate, :return
  end
end
