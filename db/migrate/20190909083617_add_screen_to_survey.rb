class AddScreenToSurvey < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :intro_screen, :text
    add_column :surveys, :final_screen, :text
  end
end
