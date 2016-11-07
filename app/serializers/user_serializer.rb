class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :password, :api_token, :api_rpm, :name, :role, :invited_by_id, :health_care_facility_id, :month_points, :total_points, :total_points, :trophies, :avatars, :badges, :image_url, :survey_day, :todays_surveys
  has_one :role
  has_many :rewards
end
