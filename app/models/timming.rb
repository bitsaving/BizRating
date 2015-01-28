class Timming < ActiveRecord::Base
  serialize :days
  
  WEED_DAYS = { 1 => 'Sunday', 2 => 'Monday', 3 => 'Tuesday', 4 => 'Wednessday',
                5 => 'Thrusday', 6 => 'Friday', 7 => 'Saturday' }

  belongs_to :business

  validates :to, :from, :days, presence: true

end