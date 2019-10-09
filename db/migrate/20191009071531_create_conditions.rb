class CreateConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :conditions do |t|
      t.text :qid
      t.text :cqid
      t.text :method
      t.text :value
      t.text :scenario

      t.timestamps
    end
  end
end
