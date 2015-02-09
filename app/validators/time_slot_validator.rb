class TimeSlotValidator < ActiveModel::EachValidator

  def validate_each (record, attribute, value)
    unless (record.business.time_slots.where.not(id: record.id).pluck(:days).flatten & value).blank?
      record.errors.add(attribute, 'are overlaped ')
    end
  end

end