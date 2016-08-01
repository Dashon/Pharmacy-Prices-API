class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :user_answer
      t.references :question, index: true, foreign_key: true
      t.references :survey, index: true, foreign_key: true
      t.timestamps null: false
    end

    add_index :answers, [:question_id, :survey_id], unique: true, :name => 'unique_survey_answers'
  end
end
