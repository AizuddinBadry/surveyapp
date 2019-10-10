class ChangeLimitToBeBigintInQuestions < ActiveRecord::Migration[6.0]
  def change
    change_column :questions, :limit, :bigint
  end
end
