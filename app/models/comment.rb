class Comment < ActiveRecord::Base
  belongs_to :discussions, dependent: :destroy
  validates_presence_of :body
end
