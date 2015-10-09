class Foreman < ActiveRecord::Base
  belongs_to :worker
  belongs_to :repair_object
end
