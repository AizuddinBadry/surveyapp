class AddErrorDetectToQuestionGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :question_groups, :any_error, :boolean, default: false
    add_column :question_groups, :verify_error, :boolean, default: false
  end
end
