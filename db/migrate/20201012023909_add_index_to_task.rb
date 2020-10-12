class AddIndexToTask < ActiveRecord::Migration[5.2]
  def up
    add_index :tasks,[:title, :status]
  end

  def down
    remove_index :tasks,[:title, :status]
  end
end
