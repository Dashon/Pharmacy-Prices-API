class UserReward < ActiveRecord::Base
  belongs_to :hcf_reward
  belongs_to :user
end
