class AddDataToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :phone_number, :string
    add_reference :users, :company, foreign_key: true
  end
end
