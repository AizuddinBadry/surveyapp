class AddInputBoxToQuestionAnswer < ActiveRecord::Migration[6.0]
  def change
    add_column :question_answers, :display_input_box_1, :boolean
    add_column :question_answers, :display_input_box_2, :boolean
    add_column :question_answers, :input_box_1_label, :text
    add_column :question_answers, :input_box_2_label, :text
    add_column :question_answers, :input_box_1_type, :text
    add_column :question_answers, :input_box_2_type, :text
  end
end
