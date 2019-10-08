class CreateSubquestions < ActiveRecord::Migration[6.0]
  def change
    create_table :subquestions do |t|
      t.references :question, null: false, foreign_key: true
      t.text :code
      t.bigint :value
      t.text :exact_value
      t.bigint :position

      t.timestamps
    end
  end
end
