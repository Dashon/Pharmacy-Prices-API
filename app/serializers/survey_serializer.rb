class SurveySerializer < ActiveModel::Serializer
  attributes :id, :survey_type
  has_one :health_care_facility
  has_one :user
end
