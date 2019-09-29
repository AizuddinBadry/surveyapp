class CreateGroupErrorLogics < ActiveRecord::Migration[6.0]
  def change
    create_table :group_error_logics do |t|
      t.references :question_group, null: false, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
