class CreateSurveyLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :survey_languages do |t|
      t.text :name
      t.references :survey, null: false, foreign_key: true

      t.timestamps
    end
  end
end
