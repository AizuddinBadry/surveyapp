class AddOtherLanguageToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :other_language, :jsonb
  end
end
