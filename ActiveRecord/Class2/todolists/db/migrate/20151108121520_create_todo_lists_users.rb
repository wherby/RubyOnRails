class CreateTodoListsUsers < ActiveRecord::Migration
  def change
    create_table :todo_lists_users do |t|
      t.references :todo_list, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
