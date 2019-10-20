class AddOtherLanguageToQuestionAnswer < ActiveRecord::Migration[6.0]
  def change
    add_column :question_answers, :other_language, :jsonb, default: {}
  end
end
