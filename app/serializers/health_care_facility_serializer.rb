class HealthCareFacilitySerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url, :team_goal,:top_users,:month_trophy,:next_reward,:team_total_points, :team_month_points
  # has_many :users
  has_many :hcf_locations
  has_many :rewards
end