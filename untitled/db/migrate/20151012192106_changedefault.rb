class Changedefault < ActiveRecord::Migration
  def change
    remove_column :transactions, :income
    add_column :transactions, :income, :boolean, :default => false
  end
end
