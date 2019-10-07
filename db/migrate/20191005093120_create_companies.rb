class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
    t.text :name
    t.text :image_data

    t.timestamps
    end
  end
end
