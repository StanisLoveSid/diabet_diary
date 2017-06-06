class Day < ApplicationRecord
  has_many :sugar_levels, dependent: :destroy
  has_many :meals, dependent: :destroy
  has_many :warnings, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_many :insulin_injections, dependent: :destroy
  belongs_to :user
  validates :created_at, uniqueness: true, if: :check_date_uniqueness

  def check_date_uniqueness
    if Day.all.map{ |d| (d.created_at.year == created_at.year) && (d.created_at.month == created_at.month) && (d.created_at.day == self.created_at.day) }.empty?
      return false
    else
      return true
    end
  end
  
  def compensated?
    total = sugar_levels.map {|e| e.status }
    return false if (total.include? "High") || (total.include? "Low")
    true
  end

end
