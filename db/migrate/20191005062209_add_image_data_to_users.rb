class AddImageDataToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :image_data, :text
  end
end
