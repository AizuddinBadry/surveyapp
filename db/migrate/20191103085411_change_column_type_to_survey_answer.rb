class ChangeColumnTypeToSurveyAnswer < ActiveRecord::Migration[6.0]
  def change
    change_column :survey_answers, :value, :string
  end
end
