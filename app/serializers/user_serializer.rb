class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :password, :api_token, :api_rpm, :name, :role, :invited_by_id, :health_care_facility_id, :month_points, :total_points, :total_points, :team_total_points, :team_month_points
  has_one :health_care_facility
  has_one :role
  has_many :rewards
  has_many :answers 
end
