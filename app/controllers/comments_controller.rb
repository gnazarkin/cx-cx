class CommentsController < ApplicationController
	include ActionController::Live

	before_action :load_experience
	before_action :load_user
	before_filter :require_login, :only => [:create]

  def index  	 @commentable = find_commentable
  	 @comments = @commentable.comments
  end

  def create
    @commentable = find_commentable # User.find(5)
    @comment = @commentable.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to polymorphic_path(@commentable) 
    else
      render :action => 'new'
    end
  end

  private

	def find_commentable
	  params.each do |name, value|
	    if name =~ /(.+)_id$/
	      return $1.classify.constantize.find(value)
	    end
	  end
	  nil
	end

	def comment_params
		params.require(:comment).permit(:body)
	end

	def load_experience
    @experience = Experience.find(params[:experience_id]) if params[:experience_id]
  end
  
  def load_user
    @user = User.find(params[:user_id]) if params[:user_id]
  end
end
