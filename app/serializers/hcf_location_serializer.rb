class HcfLocationSerializer < ActiveModel::Serializer
  attributes :id, :address, :phone, :email, :city, :state, :zip,  :latitude, :longitude, :image_url, :health_care_facility_id, :name
  has_one :user
end
