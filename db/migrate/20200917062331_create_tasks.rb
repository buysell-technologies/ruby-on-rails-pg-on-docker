class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :user_id
      t.text :text
      t.string :deadline
      t.integer :status

      t.timestamps
    end
  end
end
