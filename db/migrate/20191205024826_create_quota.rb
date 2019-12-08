class CreateQuota < ActiveRecord::Migration[6.0]
  def change
    create_table :quota do |t|
      t.text :name
      t.references :survey, null: false, foreign_key: true
      t.bigint :limit

      t.timestamps
    end
  end
end
