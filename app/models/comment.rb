class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :discussion
  validates_presence_of :body

end
