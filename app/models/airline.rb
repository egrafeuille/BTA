class Airline < ActiveRecord::Base
  has_many :results
	has_many :summaries	
  attr_accessible :name, :key
end
