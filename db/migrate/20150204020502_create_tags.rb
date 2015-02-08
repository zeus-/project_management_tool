class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.references :tag_relationship, index: true
      t.references :project

      t.timestamps null: false
    end
    add_foreign_key :tags, :tag_relationships
  end
end
