class CreateTagRelationships < ActiveRecord::Migration
  def change
    create_table :tag_relationships do |t|
      t.references :tag, index: true
      t.references :project, index: true

      t.timestamps null: false
    end
    add_foreign_key :tag_relationships, :projects
  end
end
