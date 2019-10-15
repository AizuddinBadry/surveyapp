class AddEnableOthersToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :enable_other_1, :boolean, default: false
    add_column :questions, :enable_other_2, :boolean, default: false
  end
end
