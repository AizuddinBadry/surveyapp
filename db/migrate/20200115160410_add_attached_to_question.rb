class AddAttachedToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :attached_to, :bigint
  end
end
