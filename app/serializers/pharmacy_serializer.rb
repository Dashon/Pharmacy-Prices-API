class PharmacySerializer < ActiveModel::Serializer
  attributes :id, :distance_miles_max, :distance_from_zip
end
