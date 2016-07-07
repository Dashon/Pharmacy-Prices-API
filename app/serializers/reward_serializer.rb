class RewardSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :cost, :description, :image
  has_one :user
end
