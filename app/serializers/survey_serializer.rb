class SurveySerializer < ActiveModel::Serializer
  attributes :id, :survey_type, :user_id, :health_care_facility_id
  has_many :answers
end
