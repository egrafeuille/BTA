class SearchGroup < ActiveRecord::Base
  attr_accessible :name
	has_many :searches, :dependent => :restrict
	validates :name, :presence => true
end
