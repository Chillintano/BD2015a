class Renamecolumns2 < ActiveRecord::Migration
  def change
    rename_table :objects, :repair_objects
    rename_column :assignments, :object_id, :repair_object_id
    rename_column :foremen, :object_id, :repair_object_id
    rename_column :repair_products, :object_id, :repair_object_id
    rename_column :transactions, :object_id, :repair_object_id
  end
end
