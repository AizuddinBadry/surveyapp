class AddDescriptionToSurvey < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :description, :text
    add_column :surveys, :welcome_message, :text
    add_column :surveys, :end_message, :text
    add_column :surveys, :end_url, :text
    add_column :surveys, :url_desc, :text
  end
end
