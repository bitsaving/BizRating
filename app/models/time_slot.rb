class TimeSlot < ActiveRecord::Base
  serialize :days

  WEEK_DAYS = { 1 => 'Sunday', 2 => 'Monday', 3 => 'Tuesday', 4 => 'Wednessday',
                5 => 'Thrusday', 6 => 'Friday', 7 => 'Saturday' }

  belongs_to :business, required: true

  ## FIXME_NISH Please move this in validators.

  #FIXME_AB: Need to simplify this please talk to Nishant sir

  validates :days, time_slot: true
  validate :to_is_less_than_from_time

  def to_is_less_than_from_time
    errors.add(:timimgs, "From Time can't be less than OR equal to To Time") if to <= from
  end

end
