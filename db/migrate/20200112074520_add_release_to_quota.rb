class AddReleaseToQuota < ActiveRecord::Migration[6.0]
  def change
    add_column :quota, :release, :boolean, default: :false
  end
end
