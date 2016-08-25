class DniPharmacySerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone, :email, :city, :state, :zip, :latitude, :longitude, :match_score, :surescripts_id, :stateList_id, :npi, :short_code, :image_url,:contracted,:benefits , :full_street_address, :display_name
  has_one :user
end
