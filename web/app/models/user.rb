class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         
    has_many :checkins
    has_many :objectives
    has_many :goals, through: :objectives
    has_many :friendables
    has_many :users, through: :friendables
end
