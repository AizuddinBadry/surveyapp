class AddImageDataToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :image, :text
  end
end
