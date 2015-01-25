class Discussion < ActiveRecord::Base
  belongs_to :tasks, dependent: :destroy
  has_many :comments 
  validates :title, presence: true
end
