class AddIntroductionAndFinalScreenToSurvey < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :show_intro_screen, :boolean
    add_column :surveys, :final_button_text, :text
    add_column :surveys, :final_button_url, :text
  end
end
