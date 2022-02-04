# frozen_string_literal: true

class NurseSerializer < ApplicationSerializer
  attributes :id, :name, :phone, :address, :schedules
  # has_many :nurse_schedules
end
