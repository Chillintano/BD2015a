class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :object_id, :null => false
      t.integer :worker_id, :null => false
      t.date :date_started, :null => false
      t.date :date_finished, :default => nil
      t.integer :pay, :null => false
      t.boolean :isTimed
    end
  end
end
