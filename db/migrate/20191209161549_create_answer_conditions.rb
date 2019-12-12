class CreateAnswerConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :answer_conditions do |t|
      t.text :method
      t.text :value
      t.text :scenario
      t.references :question, null: false, foreign_key: true
      t.bigint :condition_question_id
      t.bigint :row
      t.text :relation
      t.references :question_answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
