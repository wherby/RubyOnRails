class AddTodoListReferenceToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :todo_list, index: true, foreign_key: true
  end
end
