class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :user_answer
  has_one :question
end
