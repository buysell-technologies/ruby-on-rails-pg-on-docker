class CreateRelationTaskLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :relation_task_labels do |t|
      t.references :task, foreign_key: true
      t.references :label, foreign_key: true
      t.timestamps
      # 重複組合せの排除
      t.index [:task_id, :label_id], unique: true
    end
  end
end
