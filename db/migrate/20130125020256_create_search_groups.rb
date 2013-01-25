class CreateSearchGroups < ActiveRecord::Migration
  def change
    create_table :search_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
