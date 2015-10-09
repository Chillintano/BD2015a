class RepairObject < ActiveRecord::Base
  belongs_to :client
  has_many :repair_products
  has_many :assignments
  has_many :transactions
  has_one :foremen
end
