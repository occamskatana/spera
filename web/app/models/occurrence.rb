class Occurrence < ActiveRecord::Base
  belongs_to :objective
  belongs_to :user
end
