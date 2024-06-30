class CreateSubtodos < ActiveRecord::Migration[7.1]
  def change
    create_table :subtodos do |t|
      t.string :title
      t.boolean :status
      t.references :todo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
