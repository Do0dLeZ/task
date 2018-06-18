class ChangeDefaultFinishedForTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :finished, false
  end
end
