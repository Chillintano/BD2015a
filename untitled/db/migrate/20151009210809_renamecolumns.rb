class Renamecolumns < ActiveRecord::Migration
  def change
    rename_table :repair_objects, :objects
  end
end
