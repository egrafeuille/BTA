class Source < ActiveRecord::Base
  has_many :results
	has_many :summaries
  attr_accessible :name, :search_url
end
