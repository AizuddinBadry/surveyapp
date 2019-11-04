class Addstatustosurveys < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :status, :text
  end
end
