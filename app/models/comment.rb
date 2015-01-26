class Comment < ActiveRecord::Base
  belongs_to :discussions
  validates_presence_of :body
end
