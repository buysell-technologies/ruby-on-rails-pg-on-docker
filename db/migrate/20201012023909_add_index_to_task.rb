# frozen_string_literal: true

class AddIndexToTask < ActiveRecord::Migration[5.2]
  def up
    add_index :tasks, %i[title status]
  end

  def down
    remove_index :tasks, %i[title status]
  end
end
