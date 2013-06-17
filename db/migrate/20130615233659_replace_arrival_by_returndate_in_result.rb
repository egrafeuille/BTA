class ReplaceArrivalByReturndateInResult < ActiveRecord::Migration
  def up
     remove_column :results, :arrival
     add_column :results, :returndate, :datetime
  end

  def down
     remove_column :results, :returndate
     add_column :results, :arrival, :datetime
  end
end
