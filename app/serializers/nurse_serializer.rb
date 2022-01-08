# frozen_string_literal: true

class NurseSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :address, :nurse_schedules
  has_many :nurse_schedules

  def nurse_schedules
    object&.nurse_schedules&.order(id: :asc)&.map do |item|
      {
        id: item.id,
        time_start: item.schedule.time_start,
        time_end: item.schedule.time_end,
        booked: item.booked,
        created_at: item.created_at.strftime('%Y/%m/%d %H:%M:%S'),
        updated_at: item.updated_at.strftime('%Y/%m/%d %H:%M:%S')
      }
    end
  end
end
