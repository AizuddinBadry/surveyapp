class AddEnableCodeToSurvey < ActiveRecord::Migration[6.0]
  def change
    add_column :survey_settings, :enable_question_code, :boolean, default: false
    add_column :survey_settings, :enable_group_code, :boolean, default: false
    add_column :survey_settings, :enable_answer_code, :boolean, default: false
  end
end
