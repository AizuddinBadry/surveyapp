class AddHiddenToQuestionGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :question_groups, :hidden, :boolean, default: false
  end
end
