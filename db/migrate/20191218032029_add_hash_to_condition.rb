class AddHashToCondition < ActiveRecord::Migration[6.0]
  def change
    add_column :conditions, :condition_hash, :text
  end
end
