class SearchDate < ActiveRecord::Base
  attr_accessible :departure, :is_active, :returndate

  has_many :summaries

  validates :departure, :returndate, :presence => true

  scope :actives, where(:is_active => true)

end
