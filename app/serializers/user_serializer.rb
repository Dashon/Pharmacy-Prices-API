class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :password, :auth_token, :api_token, :account_active, :api_rpm
end
