class AddStartButtonTextToSurvey < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :start_button_text, :text
  end
end
