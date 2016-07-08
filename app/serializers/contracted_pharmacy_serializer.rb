class ContractedPharmacySerializer < ActiveModel::Serializer
  attributes :id , :health_care_facility_id
  #has_one :hcf_pharmacy
  #has_one :health_care_facility
  has_one :dni_pharmacy
  has_one :user
end
