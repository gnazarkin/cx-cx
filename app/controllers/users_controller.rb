class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
  		redirect_to root_path, notice: "User successfully created"
  	else 
  		render "new"
  	end 

  end

  def show
  	@user = User.find(params[:id])
    @comments = @user.comments
    @experiences = @user.experiences.order("experiences.created_at DESC").page(params[:page])
  end 

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path
    else 
      render :edit
    end

  end

  private
  def user_params
  	params.require(:user).permit(:first_name, :last_name, :bio, :email, :password, :password_confirmation)
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
