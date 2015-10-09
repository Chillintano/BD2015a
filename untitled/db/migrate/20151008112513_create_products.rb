class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :description, :null => false
    end
  end
end
