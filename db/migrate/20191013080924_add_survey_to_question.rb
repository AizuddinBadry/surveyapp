class AddSurveyToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :survey_id, :bigint
    add_column :questions, :survey_position, :bigint
  end
end
