class Deletedatetosurveys < ActiveRecord::Migration[6.0]
  def change
    remove_column :surveys, :start_time
    remove_column :surveys, :end_time
    add_column :survey_settings, :start_time, :datetime
    add_column :survey_settings, :end_time, :datetime
  end
end
