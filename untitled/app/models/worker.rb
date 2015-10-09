class Worker < ActiveRecord::Base
  has_many :assignments
  has_many :foremen
end
