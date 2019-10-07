class RemoveImageDataFromUsers < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :image_data, :text
  end
end
