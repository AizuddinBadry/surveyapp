class CreateSurveySessions < ActiveRecord::Migration[6.0]
  def change
    create_table :survey_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :survey, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.text :string

      t.timestamps
    end
  end
end
