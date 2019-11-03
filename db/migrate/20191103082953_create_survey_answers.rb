class CreateSurveyAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :survey_answers do |t|
      t.references :survey, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.bigint :value
      t.text :session

      t.timestamps
    end
  end
end
