class Airline < ActiveRecord::Base
  has_many :results
  attr_accessible :name, :key
end
