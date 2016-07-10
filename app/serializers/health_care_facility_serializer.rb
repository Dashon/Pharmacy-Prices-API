class HealthCareFacilitySerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url
  has_many :users
  has_many :hcf_locations
end