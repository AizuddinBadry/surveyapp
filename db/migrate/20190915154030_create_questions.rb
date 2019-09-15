class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.references :question_group, null: false, foreign_key: true
      t.text :q_type
      t.text :code
      t.text :description
      t.text :help
      t.boolean :mandatory
      t.bigint :position

      t.timestamps
    end
  end
end
