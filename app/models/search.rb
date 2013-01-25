class Search < ActiveRecord::Base
  belongs_to :city_from, :class_name => "City"
  belongs_to :city_to, :class_name => "City"
	belongs_to :search_group
  has_many :results
  attr_accessible :city_from_id, :city_to_id, :active, :return, :departure, :priority, :search_group_id
  validates :return, :departure, :priority, :presence => true
end
