class HealthCareFacility < ActiveRecord::Base
  has_many :users
  has_many :hcf_locations
end
