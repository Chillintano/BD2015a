class CreateRepairObjects < ActiveRecord::Migration
  def change
    create_table :repair_objects do |t|
      t.string :description
      t.integer :client_id, :null => false
    end
  end
end
