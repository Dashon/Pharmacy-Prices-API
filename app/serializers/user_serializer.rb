class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :password, :api_token, :api_rpm, :name
  has_one :role
end
