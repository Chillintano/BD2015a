class AddDates < ActiveRecord::Migration
  def change
    add_column :repair_objects, :date_started, :date
    add_column :repair_objects, :date_finished, :date
  end
end
