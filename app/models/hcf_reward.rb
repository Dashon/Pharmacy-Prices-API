class HcfReward < ActiveRecord::Base
  belongs_to :reward
  belongs_to :health_care_facility
  belongs_to :user
end
