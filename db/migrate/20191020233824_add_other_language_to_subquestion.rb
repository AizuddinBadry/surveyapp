class AddOtherLanguageToSubquestion < ActiveRecord::Migration[6.0]
  def change
    add_column :subquestions, :other_language, :jsonb, default: {}
  end
end
