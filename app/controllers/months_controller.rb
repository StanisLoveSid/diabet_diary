class MonthsController < ApplicationController
  
  def create
  	@year = Year.find(params[:year_id])
    @user = current_user
    @year.months.create(month_params)
    redirect_to :root		
  end

  def index
  	@months = Month.all
  end

  def show
  	@year = Year.find(params[:year_id])
  	@month = Month.find(params[:id])
  	@status_hash = {}
  	@sug = @month.days.map{|day| day.sugar_levels.map{|sl| sl.status }}
    @status_hash[:Low] = @sug.flatten.count("High")
  	@status_hash[:High] = @sug.flatten.count("Low")
  	@status_hash[:Normal] = @sug.flatten.count("Normal")
  	@total = []
  	i = 0
  	@month.days.each do |day|
      i += 1  
      mmols = day.sugar_levels.map {|e| e.mmol}
      time  = day.sugar_levels.map {|e| e.created_at}
      @total << {name: "Day #{i}", data: time.zip(mmols).to_h, type: "area"}		
  	end
  end

  private

  def month_params
  	params.require(:month).permit(:description, :created_at, :year_id)	
  end	

end