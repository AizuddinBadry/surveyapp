class RemoveSurveyColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :surveys, :description
    remove_column :surveys, :end_url
    remove_column :surveys, :url_desc
    remove_column :surveys, :intro_screen
    remove_column :surveys, :final_screen

  end
end
