class AddButtonBackStartToSurvey < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :final_button_to_start, :boolean, :default => false
  end
end
