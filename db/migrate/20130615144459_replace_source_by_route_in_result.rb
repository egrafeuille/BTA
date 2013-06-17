class ReplaceSourceByRouteInResult < ActiveRecord::Migration
  def up
     remove_column :results, :search_id
     add_column :results, :route_id, :integer
  end

  def down
     add_column :results, :search_id, :integer
     remove_column :results, :route_id   
  end
end
