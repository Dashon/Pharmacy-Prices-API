class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :value
  has_one :survey
end
