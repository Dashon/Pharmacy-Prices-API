class CreateSurveyDays < ActiveRecord::Migration
  def change
    create_table :survey_days do |t|
      t.references :user, index: true, foreign_key: true
      t.references :health_care_facility, index: true, foreign_key: true
      t.integer :expected_patients

      t.timestamps null: false
    end
  end
end
