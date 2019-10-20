class CreateQuestionOtherLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :question_other_languages do |t|
      t.text :description
      t.references :survey_language, null: false, foreign_key: true

      t.timestamps
    end
  end
end
