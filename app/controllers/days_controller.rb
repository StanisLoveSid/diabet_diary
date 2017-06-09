class DaysController < ApplicationController

  def index
    @days = Day.all
    @sugar_levels = SugarLevel.by_month(params[:month])
  end

  def create
    @year = Year.find(params[:year_id])
    @month = Month.find(params[:month_id])
    data = []
    @month.days.each { |d| data << d.day_number }
    unless data.include? day_params[:day_number].to_i
      @month.days.create(day_params)
    else
      flash[:notice] = "Day already exists"
    end
    redirect_to :back
  end

  def show
    @year = Year.find(params[:year_id])
    @month = Month.find(params[:month_id])
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
    @year = Year.find(params[:year_id])
    @month = Month.find(params[:month_id])
    @day.destroy
    redirect_to year_month_path(@year, @month)
  end

  private

  def day_params
    params.require(:day).permit(:data, :description, :day_number, :month_id)
  end

end
