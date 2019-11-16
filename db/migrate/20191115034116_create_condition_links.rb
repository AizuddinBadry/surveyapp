class CreateConditionLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :condition_links do |t|
      t.references :question, null: false, foreign_key: true
      t.references :condition, null: false, foreign_key: true
      t.text :relation
      t.bigint :other_condition_id

      t.timestamps
    end
  end
end
