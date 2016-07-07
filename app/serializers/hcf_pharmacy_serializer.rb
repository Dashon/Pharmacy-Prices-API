class HcfPharmacySerializer < ActiveModel::Serializer
  attributes :id, :external_id, :health_care_facility_id
  has_one :dni_pharmacy
  has_one :health_care_facility
end
