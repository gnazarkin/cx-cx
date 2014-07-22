class ExperiencesController < ApplicationController
  def index
    @experiences = Experience.all
  end

  def new
    @experience = Experience.new
  end

  def show
    @experience = Experience.find(params[:id])
  end

  def create
    @experience = Experience.new(experience_params)
  end

  def update
    @experience = Experience.find(params[:id])
  end

  def destroy
    @experience = Experience.find(params[:id])
    @experience.destroy
  end

  private
  def params.require(:expreience).permit(:name, :description, :start_time, :end_time, :price)  
  end
end
