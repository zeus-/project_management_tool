class Discussion < ActiveRecord::Base
  belongs_to :tasks 
  has_many :comments, dependent: :destroy
  validates :title, presence: true
end
