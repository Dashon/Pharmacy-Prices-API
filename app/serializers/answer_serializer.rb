class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :user_answer, :survey_id
  has_one :user
  has_one :question
end
