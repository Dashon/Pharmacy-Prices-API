class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :password, :api_token, :api_rpm, :name, :role
  has_one :health_care_facility
end
