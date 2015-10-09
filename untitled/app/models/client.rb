class Client < ActiveRecord::Base
  has_many :transactions
  has_many :repair_objects
end
