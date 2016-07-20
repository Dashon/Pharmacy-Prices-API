class Survey < ActiveRecord::Base
  belongs_to :health_care_facility
  belongs_to :user
  has_many :questions
  has_many :answers, :through => :questions
end
