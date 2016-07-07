class ContractedPharmacy < ActiveRecord::Base
  belongs_to :hcf_pharmacy
  belongs_to :user
end
