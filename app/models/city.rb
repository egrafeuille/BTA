class City < ActiveRecord::Base
  attr_accessible :country_id, :name
  belongs_to :country
  has_many :airports, :dependent => :restrict
end
