class Month < ApplicationRecord
  belongs_to :user
  belongs_to :year
  has_many :days

  def average_month
  	all_days = days.map {|day| day.average }
  	amount = all_days.count
  	sum = all_days.inject(0) { |sum, x| sum + x }
  	sum / amount
  end

end
