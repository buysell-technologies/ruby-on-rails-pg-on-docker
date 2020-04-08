class CreateTaskLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :task_labels do |t|
      t.references :task, foreign_key: true, index: true
      t.references :label, foreign_key: true, index: true

      t.timestamps
    end
  end
end
