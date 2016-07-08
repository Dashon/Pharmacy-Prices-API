class ContractedPharmacy < ActiveRecord::Base
  belongs_to :hcf_pharmacy
  belongs_to :health_care_facility
  belongs_to :user
  has_one :dni_pharmacy, :through => :hcf_pharmacy
  
end
