class PharmacyBenefit < ActiveRecord::Base
  belongs_to :benefit
  belongs_to :dniPharmacy
end
