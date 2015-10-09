class CreateRepairProducts < ActiveRecord::Migration
  def change
    create_table :repair_products do |t|
      t.integer :product_id, :null => false
      t.integer :object_id, :null => false
      t.integer :volume
    end
  end
end
