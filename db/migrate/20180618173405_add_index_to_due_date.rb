class AddIndexToDueDate < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :due_date
  end
end
