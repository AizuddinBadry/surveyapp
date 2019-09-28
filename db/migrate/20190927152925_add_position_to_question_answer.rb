class AddPositionToQuestionAnswer < ActiveRecord::Migration[6.0]
  def change
    add_column :question_answers, :position, :integer
  end
end
