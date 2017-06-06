class ExercisesController < ApplicationController
  
  def create
    @day = Day.find(params[:day_id])
    @day.exercises.create(exercise_params)
    redirect_to @day
  end

  private

  def exercise_params
    params.require(:exercise).permit(:status, :description, :created_at, :day_id_)
  end

end 
