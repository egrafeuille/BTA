class Search < ActiveRecord::Base
  belongs_to :city_from, :class_name => "City"
  belongs_to :city_to, :class_name => "City"
  attr_accessible :city_from_id, :city_to_id, :active, :arrival, :departure, :priority
  validates :arrival, :departure, :priority, :presence => true
end
