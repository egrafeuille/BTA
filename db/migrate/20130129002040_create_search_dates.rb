class CreateSearchDates < ActiveRecord::Migration
  def change
    create_table :search_dates do |t|
      t.datetime :departure
      t.datetime :return
      t.boolean :is_active

      t.timestamps
    end
  end
end
