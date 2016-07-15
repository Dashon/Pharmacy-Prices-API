class PharmacyBenefitSerializer < ActiveModel::Serializer
  attributes :id
  has_one :benefit
  has_one :dniPharmacy
end
