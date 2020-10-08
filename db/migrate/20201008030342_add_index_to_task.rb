class AddIndexToTask < ActiveRecord::Migration[5.2]
  def up
    add_index :tasks, :title
    add_index :tasks,:text
  end
  def down
    remove_index :tasks, :title
    remove_index :tasks, :text
  end
end
