class Dropdate < ActiveRecord::Migration
  def change
    remove_column :foremen, :date
  end
end
