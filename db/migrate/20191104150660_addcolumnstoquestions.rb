class Addcolumnstoquestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :column, :bigint
  end
end
