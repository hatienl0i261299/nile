class Schedule < ApplicationRecord
    has_many :nurse_schedules
    has_many :nurses, through: :nurse_schedules
end
