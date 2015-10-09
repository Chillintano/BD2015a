class RepairProduct < ActiveRecord::Base
  belongs_to :repair_object
  belongs_to :product
end
