class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false, comment: 'タイトル'
      t.text :detail, comment: '詳細'

      t.timestamps
    end
  end
end
