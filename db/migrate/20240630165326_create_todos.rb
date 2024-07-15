class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.string :importance
      t.text :notes
      t.boolean :status
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
