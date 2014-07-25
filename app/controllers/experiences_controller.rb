class ExperiencesController < ApplicationController
    before_filter :require_login, :only => [:new, :edit, :update, :destroy, :create]
  
  def index
    if params[:search]
      @experiences = Experience.where("LOWER(name) LIKE LOWER(?)", "%#{params[:search]}%")
    else 
      @experiences = Experience.order("experiences.created_at DESC").page(params[:page])
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @experience = Experience.new
  end

  def show
    @experience = Experience.find(params[:id])
    @user = @experience.user
    @commentable = find_commentable
    @comments = @experience.comments
  end

  def create
    @experience = Experience.new(experience_params)
    @experience.user = current_user

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

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
