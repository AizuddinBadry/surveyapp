class ChangeDatatypeInConditions < ActiveRecord::Migration[6.0]
  def change

    remove_column :conditions, :qid, :text
    remove_column :conditions, :cqid, :text
    add_column :conditions, :question_id, :bigint, references: :question
    add_column :conditions, :condition_question_id, :bigint, references: :question, foreign_key: true

  end
end