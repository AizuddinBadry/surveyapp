class Adddetailstoquestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :q_desc, :text
    add_column :questions, :helper, :text
    add_column :questions, :d_qcode, :text
  end
end
