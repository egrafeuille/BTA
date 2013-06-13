class City < ActiveRecord::Base
  attr_accessible :country_id, :name
  belongs_to :country
  has_many :airports, :dependent => :restrict
  has_many :generic_searches, :dependent => :restrict
  has_many :routes, :dependent => :restrict
end
