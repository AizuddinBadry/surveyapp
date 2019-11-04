class Addrandomizetoquestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :randomize, :boolean
  end
end
