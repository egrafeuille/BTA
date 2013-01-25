class Search < ActiveRecord::Base
  belongs_to :city_from, :class_name => "City"
  belongs_to :city_to, :class_name => "City"
  has_many :results
  attr_accessible :city_from_id, :city_to_id, :active, :return, :departure, :priority
  validates :return, :departure, :priority, :presence => true
end
