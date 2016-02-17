class Checkin < ActiveRecord::Base
  belongs_to :user

  enum mood: [:excellent, :good, :so_so, :bad, :terrible, :suicidal]
end
