class HealthCareFacilitySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :users
  has_many :hcf_locations
end
