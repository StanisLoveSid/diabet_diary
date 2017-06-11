class User < ApplicationRecord
  has_friendship
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :days 
  has_many :months
  has_many :years  

end
