class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :type
      t.references :health_care_facility, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
