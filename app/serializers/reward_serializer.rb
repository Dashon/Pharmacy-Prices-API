class RewardSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :cost, :description, :image_url
  has_one :user
end
