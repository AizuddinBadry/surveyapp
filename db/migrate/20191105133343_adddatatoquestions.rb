class Adddatatoquestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :help_other_language, :jsonb, default: {}
    add_column :questions, :question_desc_other_language, :jsonb, default: {}
    rename_column :questions, :q_desc, :question_desc
    rename_column :questions, :d_qcode, :desc_question_code
    remove_column :questions, :helper
  end
end
