class Timming < ActiveRecord::Base
  serialize :days
  
  WEEK_DAYS = { 1 => 'Sunday', 2 => 'Monday', 3 => 'Tuesday', 4 => 'Wednessday',
                5 => 'Thrusday', 6 => 'Friday', 7 => 'Saturday' }

  belongs_to :business, required: true

  validates_each :days do |record, attribute, value|
    record.errors.add(attribute, 'overlaped') unless (record.business.timmings.where.not(id: record.id).pluck(:days).flatten & value).empty?
  end

end