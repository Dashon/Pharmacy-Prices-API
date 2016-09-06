class AddSurveyDaysToSurveys < ActiveRecord::Migration
  def change
    add_reference :surveys, :survey_day, index: true, foreign_key: true
  end
end
