class CreateQuestionAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :question_answers do |t|
      t.references :question, null: false, foreign_key: true
      t.text :code
      t.bigint :value
      t.text :exact_value

      t.timestamps
    end
  end
end
