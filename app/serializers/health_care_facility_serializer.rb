class HealthCareFacilitySerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url, :team_goal,:top_users,:month_trophy,:next_reward
  has_many :users
  has_many :hcf_locations
  has_many :rewards
end