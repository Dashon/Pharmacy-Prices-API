class Survey < ActiveRecord::Base
  belongs_to :health_care_facility
  belongs_to :user
end
