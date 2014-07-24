class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :author, :class_name => "User"

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  validates :body, presence: true
end
