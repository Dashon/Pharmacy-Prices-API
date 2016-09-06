class Survey < ActiveRecord::Base
  belongs_to :health_care_facility
  belongs_to :user
  belongs_to :survey_day
  has_many :answers
  has_many :questions, :through => :answers

end
