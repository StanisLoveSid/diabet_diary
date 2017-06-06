class DaysController < ApplicationController

  def index
    @days = Day.all
  end

  def create
    @user = current_user
    current_user.days.create(day_params)
    redirect_to :root
  end

  def show
    @day = Day.find(params[:id])
    @s_l = @day.sugar_levels.group_by_minute(:created_at).sum(:mmol)
    @result = @s_l.select{|k, v| v != 0}

    @meals = @day.meals.group_by_minute(:created_at).sum(4)
    @meals_result = @meals.select{|k, v| v != 0}

    @insulin = @day.insulin_injections.group_by_minute(:created_at).sum(3)
    @insulin_result = @insulin.select{|k, v| v != 0}

    @exercise_start = @day.exercises.where("status = ?", "start").group_by_minute(:created_at).sum(10)
    @exercise_end = @day.exercises.where("status = ?", "end").group_by_minute(:created_at).sum(10)

    @warning_start = @day.warnings.where("reason = ?", "start").group_by_minute(:created_at).sum(15)
    @warning_end = @day.warnings.where("reason = ?", "end").group_by_minute(:created_at).sum(15)
    
  end

  def destroy
    @day = Day.find(params[:id])
    @day.destroy
    redirect_to :root
  end

  private

  def day_params
    params.require(:day).permit(:data, :description, :created_at)
  end

end
