class AddSeveralFieldsToResult < ActiveRecord::Migration
  def change
    add_column :results, :result_type, :string, :default=>"RT"
    add_column :results, :is_roundtrip, :boolean, :default=>true
    add_column :results, :ticket_class, :string, :default=>"EC"
    add_column :results, :result_date, :datetime
  end
end
