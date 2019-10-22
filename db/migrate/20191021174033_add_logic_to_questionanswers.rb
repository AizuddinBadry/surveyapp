class AddLogicToQuestionanswers < ActiveRecord::Migration[6.0]
  def change
    add_column :question_answers, :logic, :text
  end
end
