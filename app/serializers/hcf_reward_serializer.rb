class HcfRewardSerializer < ActiveModel::Serializer
  attributes :id
  has_one :reward
  has_one :health_care_facility
  has_one :user
end
