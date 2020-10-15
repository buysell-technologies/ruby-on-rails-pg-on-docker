# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :text
      t.string :deadline
      t.integer :user_id

      t.timestamps
    end
  end
end
