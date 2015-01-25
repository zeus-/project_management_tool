class AddReferencesToDiscussions < ActiveRecord::Migration
  def change
    add_reference :discussions, :task, index: true
    add_foreign_key :discussions, :tasks
  end
end
