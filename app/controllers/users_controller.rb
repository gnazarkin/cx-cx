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
  end 

  def edit
    @user = User.find(params[:id])

    if @user.save
      redirect_to root_url
    else
      render :edit
    end
    
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to root_url
    else 
      render :edit
    end

  end

  private
  def user_params
  	params.require(:user).permit(:first_name, :last_name, :bio, :email, :password, :password_confirmation)
  end
end
