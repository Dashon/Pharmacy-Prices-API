class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :survey
  has_one :user
end
