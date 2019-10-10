class AddAnswerLimitToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :limit, :integer
  end
end
