class DrugPriceSerializer < ActiveModel::Serializer
  attributes :id, :days_supply, :quantity, :generic_id, :ndc11
end
