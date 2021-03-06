class User < ActiveRecord::Base

  authenticates_with_sorcery!

  validates :password, length: { minimum: 8 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true


  has_many :experiences
  has_many :comments, :as => :commentable
  has_many :authored_comments, :class_name => "Comment", :foreign_key => "author_id"

  def full_name
  	"#{first_name} #{last_name}"
  end


end

