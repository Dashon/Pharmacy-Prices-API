class HcfLocationSerializer < ActiveModel::Serializer
  attributes :id, :address, :phone, :email, :city, :state, :zip, :logo, :health_care_facility_id
  has_one :user
end
