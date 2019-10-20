class AddSurveyLanguageIdToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_reference :questions, :survey_language, null: true, foreign_key: true
  end
end
