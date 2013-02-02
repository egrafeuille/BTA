class AddWhenAndIsActiveToGenericSearch < ActiveRecord::Migration
  def change
    add_column :generic_searches, :when, :string
    add_column :generic_searches, :is_active, :boolean
  end
end
