class CreateForemen < ActiveRecord::Migration
  def change
    create_table :foremen do |t|
      t.integer :worker_id, :null => false
      t.integer :object_id, :null => false
      t.date :date, :null => false
    end
  end
end
