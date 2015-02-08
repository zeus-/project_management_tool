class RemoveTags < ActiveRecord::Migration
 def change
    drop_table :tags do |t|
    end
  end
end
