class AddLogoToSurveys < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :image_data, :text
  end
end
