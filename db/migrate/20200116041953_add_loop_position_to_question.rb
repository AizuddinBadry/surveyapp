class AddLoopPositionToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :loop_position, :bigint
  end
end
