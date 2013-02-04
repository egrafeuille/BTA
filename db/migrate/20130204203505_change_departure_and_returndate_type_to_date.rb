class ChangeDepartureAndReturndateTypeToDate < ActiveRecord::Migration
  def up
    change_column :search_dates, :departure, :date
    change_column :search_dates, :returndate, :date
  end

  def down
    change_column :search_dates, :departure, :datetime
    change_column :search_dates, :returndate, :datetime
  end
end
