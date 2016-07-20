class Reward < ActiveRecord::Base
  belongs_to :user
  enum reward_type_list: {trophy: 1, avatar: 2, badge: 3}

end
