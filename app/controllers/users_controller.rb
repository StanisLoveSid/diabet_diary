class UsersController < ApplicationController
  def index
    @sugar_levels = SugarLevel.all
    @creation_time = @sugar_levels.select(:created_at).map(&:created_at).map(&:hour)
    @mmol_analysis = @sugar_levels.select(:mmol).map(&:mmol).map(&:to_f)
    @mmol_and_time = @creation_time.zip @mmol_analysis
    @s_l = SugarLevel.group_by_minute(:created_at).sum(:mmol)
    @result = @s_l.select{|k, v| v != 0}
  end
end
