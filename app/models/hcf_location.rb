class HcfLocation < ActiveRecord::Base
  belongs_to :user
  belongs_to :health_care_facility
end
