class AddShowFinalButtonToSurvey < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :show_final_button, :boolean, :default => false
  end
end
