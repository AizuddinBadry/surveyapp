class CreateSurveySettings < ActiveRecord::Migration[6.0]
  def change
    create_table :survey_settings do |t|
      t.boolean :enable_pdpa
      t.text :pdpa_message
      t.text :pdpa_error_message

      t.timestamps
    end
  end
end
