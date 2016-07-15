class HcfPharmacy < ActiveRecord::Base
  belongs_to :health_care_facility
  belongs_to :dni_pharmacy
  belongs_to :user

end
