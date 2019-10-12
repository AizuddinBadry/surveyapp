class ChangeColumnNameToQuestionGroup < ActiveRecord::Migration[6.0]
  def change
    rename_column :question_groups, :order, :position
  end
end
