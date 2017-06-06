class SugarLevelsController < ApplicationController

before_action :set_day, only: [:destroy]

  def edit
    
  end

  def show
    
  end

  def destroy
    @sugar_level.destroy
    redirect_to :back
  end

  def create
    @day = Day.find(params[:day_id])
    @day.sugar_levels.create(sugar_level_params)
    redirect_to :back
  end

  private

  def set_day
    @day = Day.find(params[:day_id])
    @sugar_level = @day.sugar_levels.find(params[:id])
  end

  def sugar_level_params
    params.require(:sugar_level).permit(:mmol, :status, :day_id, :created_at)
  end
end
