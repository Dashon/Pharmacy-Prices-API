class PharmacyEditRequestSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone, :email, :city, :state, :zip, :latitude, :longitude, :surescripts_id, :stateList_id, :approved, :denied
  has_one :dni_pharmacy
  has_one :user
end
