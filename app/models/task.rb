class Task < ActiveRecord::Base
  
  belongs_to :project
  has_many :discussions, dependent: :destroy
  validates_presence_of :title
  validates :title, uniqueness: {scope: :project_id}

end
