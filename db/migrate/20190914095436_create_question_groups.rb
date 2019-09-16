class CreateQuestionGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :question_groups do |t|
      t.bigint :order
      t.text :name
      t.text :description
      t.references :survey, null: false, foreign_key: true

      t.timestamps
    end
  end
end
