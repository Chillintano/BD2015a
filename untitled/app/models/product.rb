class Product < ActiveRecord::Base
  has_one :repair_product
  has_many :transactions
end
