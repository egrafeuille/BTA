class Source < ActiveRecord::Base
  has_many :results
  attr_accessible :name, :search_url
end
