class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :client_id, :null => false
      t.integer :object_id, :null => false
      t.integer :product_id, :default => nil
      t.integer :volume, :default => nil
      t.integer :value, :null => false
      t.boolean :income, :default => true
      t.string :description
      t.timestamps
    end
  end
end
