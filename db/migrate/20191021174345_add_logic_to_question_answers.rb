class AddLogicToQuestionAnswers < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :logic, :text
  end
end
