class AddDoneAndBodyToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :body, :text
    add_column :tasks, :done, :boolean
  end
end
