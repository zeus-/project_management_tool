class RemoveReferencesFromDiscussions < ActiveRecord::Migration
  def change
    remove_reference :discussions, :task, index: true
  end
end
