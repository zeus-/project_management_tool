class Tag < ActiveRecord::Base
  has_many :tag_relationships, dependent: :destroy
  has_many :projects, through: :tag_relationships
  validates_presence_of :name
  validates_uniqueness_of :name
end
