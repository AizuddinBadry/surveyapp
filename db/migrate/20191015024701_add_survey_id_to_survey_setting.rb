class AddSurveyIdToSurveySetting < ActiveRecord::Migration[6.0]
  def change
    add_reference :survey_settings, :survey, null: false, foreign_key: true
  end
end
