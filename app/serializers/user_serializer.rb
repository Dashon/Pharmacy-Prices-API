class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :password, :api_token, :api_rpm, :name, :role, :invited_by_id, :health_care_facility_id
  has_one :health_care_facility
  has_one :role
end
