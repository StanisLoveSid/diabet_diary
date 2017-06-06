class Year < ApplicationRecord
  belongs_to :user
  has_many :months
end
