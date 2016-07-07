class ContractedPharmacySerializer < ActiveModel::Serializer
  attributes :id
  has_one :hcf_pharmacy
  has_one :user
end
