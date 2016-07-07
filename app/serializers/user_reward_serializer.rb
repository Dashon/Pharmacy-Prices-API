class UserRewardSerializer < ActiveModel::Serializer
  attributes :id, :redeemed
  has_one :hcf_reward
  has_one :user
end
