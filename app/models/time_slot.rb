class TimeSlot < ActiveRecord::Base
  serialize :days

  WEEK_DAYS = { 0 => 'Sunday', 1 => 'Monday', 2 => 'Tuesday', 3 => 'Wednessday',
                4 => 'Thrusday', 5 => 'Friday', 6 => 'Saturday' }

  belongs_to :business, required: true

  ## FIXME_NISH Please move this in validators.
  ## FIXED
  #FIXME_AB: Need to simplify this please talk to Nishant sir
  ## FIXED

  validates :days, time_slot: true
  validate :to_is_less_than_from_time

  #FIXME_AB: use Better method names, like opening_time. Also should be a private method
  def to_is_less_than_from_time
    errors.add(:timimgs, "From Time can't be less than OR equal to To Time") if to <= from
  end

  def week_days
    WEEK_DAYS.values_at(*days.map { |x| x.to_i }).join(', ')
  end

end
