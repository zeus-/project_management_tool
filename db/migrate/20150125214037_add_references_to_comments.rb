class AddReferencesToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :discussion, index: true
    add_foreign_key :comments, :discussions
  end
end
