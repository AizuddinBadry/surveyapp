class AddStructureToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :structure, :text
  end
end
