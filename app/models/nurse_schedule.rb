# frozen_string_literal: true

class NurseSchedule < ApplicationRecord
  # validates_each :booked do |record, attr, value|
  #   p record
  #   p attr
  #   p value
  #   unless %w[true value].include? value
  #     puts value
  #     record.errors.add(attr, "#{value} is not a valid type")
  #   end
  # end

  # validates :booked, inclusion: { in: %w[true false], message: "'%{value}' is not a valid type" }

  belongs_to :schedule
  belongs_to :nurse
end
