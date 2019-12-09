class AddCompleteCountToQuota < ActiveRecord::Migration[6.0]
  def change
    add_column :quota, :complete_count, :bigint, default: 0
  end
end
