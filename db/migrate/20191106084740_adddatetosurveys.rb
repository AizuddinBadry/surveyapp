class Adddatetosurveys < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :start_time, :datetime
    add_column :surveys, :end_time, :datetime
  end
end
