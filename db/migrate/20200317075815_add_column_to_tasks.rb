class AddColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline_date, :date
    add_column :tasks, :status, :integer
    add_column :tasks, :important, :boolean
  end
end
