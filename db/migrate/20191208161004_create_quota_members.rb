class CreateQuotaMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :quota_members do |t|
      t.bigint :question_id
      t.bigint :answer_value
      t.references :quota, null: false, foreign_key: true

      t.timestamps
    end
  end
end
