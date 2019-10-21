class RemoveLogicToQuestionAnswers < ActiveRecord::Migration[6.0]
  def change
    remove_column :question_answers, :logic, :text
  end
end
