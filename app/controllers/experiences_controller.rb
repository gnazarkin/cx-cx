class ExperiencesController < ApplicationController
  def index
    @experiences = Experience.all
  end

  def new
    @experience = Experience.new
  end

  def show
    @experience = Experience.find(params[:id])
    @user = @experience.user
  end

  def create
    @experience = Experience.new(experience_params)
    @experience.user_id = current_user.id

    if @experience.save
      redirect_to experiences_path, notice: "Experience created successfully"
    else
      render :new
    end 
  end

  def update
    @experience = Experience.find(params[:id])
  end

  def destroy
    @experience = Experience.find(params[:id])
    @experience.destroy
  end

  private
  def experience_params
    params.require(:experience).permit(:name, :description, :start_time, :end_time, :price)  
  end
end
