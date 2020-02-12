class AddMediaToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :media, :text
  end
end
