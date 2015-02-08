class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :discussions, dependent: :destroy
  
  validates :title, presence: true, uniqueness: true 
  
  has_many :joiners, dependent: :destroy
  has_many :joined_users, through: :joiners, source: :user
  
  has_many :tag_relationships, dependent: :destroy
  has_many :tags, through: :tag_relationships
  
  has_many :favourites, dependent: :destroy
  has_many :favourited_users, through: :favourites, source: :user


end
