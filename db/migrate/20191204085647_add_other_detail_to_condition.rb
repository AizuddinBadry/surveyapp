class AddOtherDetailToCondition < ActiveRecord::Migration[6.0]
  def change
    add_column :conditions, :row, :bigint, default: 0
    add_column :conditions, :relation, :text, default: nil
  end
end
