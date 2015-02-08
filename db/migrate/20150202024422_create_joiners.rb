class CreateJoiners < ActiveRecord::Migration
  def change
    create_table :joiners do |t|
      t.references :project, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :joiners, :projects
    add_foreign_key :joiners, :users
  end
end
