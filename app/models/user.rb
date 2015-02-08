class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :disucussions, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_many :joiners, dependent: :destroy
  has_many :joined_projects, through: :joiners, source: :project
  
  has_many :tags, dependent: :destroy
  has_many :tagged_projects, through: :tags, source: :project
  
  has_many :favourites, dependent: :destroy
  has_many :favourited_projects, through: :favourites, source: :project
 
  def full_name
    if first_name || last_name
     "#{first_name} #{last_name}"
    else
      email
    end
  end
   
  def has_faved?(project)
    Favourite.where(user_id: id, project_id: project.id).present?
    #liked_questions.include? question
  end

end
