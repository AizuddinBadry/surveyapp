class AddSqlFormatToAnswerCondition < ActiveRecord::Migration[6.0]
  def change
    add_column :answer_conditions, :sql_format, :text
  end
end
