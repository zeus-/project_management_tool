class Task < ActiveRecord::Base
  
  belongs_to :project, dependent: :destroy
  has_many :discussions
  validates :title, presence: true, uniquness: true {scope: :project_id}
end
