class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :title, presence: true, uniqueness: {scope: :project_id}

end
