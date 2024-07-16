class AddUserToSubtodos < ActiveRecord::Migration[7.1]
  def change
    add_reference :subtodos, :user, null: false, foreign_key: true
  end
end
