class Transaction < ActiveRecord::Base
  belongs_to :client
  belongs_to :repair_object
  belongs_to :product
end
