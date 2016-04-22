class DrugSerializer < ActiveModel::Serializer
  attributes :id, :ndc11, :name, :name_prefix, :generic_id, :therapy_class_id
end
