class ChangeTasksColumn < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :status, :integer, limit: 1
    change_column :tasks, :important, :boolean, default: false, null: false
  end
  def down
    change_column :tasks, :status, :integer
    change_column :tasks, :important, :boolean
  end
end
