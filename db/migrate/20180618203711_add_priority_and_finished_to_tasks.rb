class AddPriorityAndFinishedToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :finished, :boolean, default: false
  end
end
