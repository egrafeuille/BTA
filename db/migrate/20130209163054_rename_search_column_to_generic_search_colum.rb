class RenameSearchColumnToGenericSearchColum < ActiveRecord::Migration
  def up
    rename_column :summaries, :search_id, :generic_search_id
  end

  def down
        rename_column :summaries, :generic_search_id, :search_id 
  end
end
