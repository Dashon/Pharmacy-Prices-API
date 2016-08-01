class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :user_answer
    has_one :user
  has_one :question
end
