class Route < ActiveRecord::Base
  attr_accessible :city_from_id, :city_to_id, :info_priority, :is_active
  
  belongs_to :city_from, :class_name => "City"
  belongs_to :city_to, :class_name => "City"

  validates :city_from_id, :city_to_id, :info_priority, :presence => true
  validates :city_from_id, :uniqueness => {:scope => :city_to_id}

  scope :actives, where(:is_active => true)
  scope :info_priority, lambda { |pri| where(:info_priority => pri) }

end
