class Addtimetosubmission < ActiveRecord::Migration[6.0]
  def change
    add_column :survey_answers, :time_per_question, :time
  end
end
