class AddCurrentUserToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :current_user, :string
  end
end
