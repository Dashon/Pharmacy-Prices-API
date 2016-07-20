class DniPharmacySerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone, :email, :city, :state, :zip, :latitude, :longitude, :match_score, :surescripts_id, :stateList_id, :npi, :short_code, :image_url,:contracted,:benefits
  has_one :user
  has_many :benefits
end
