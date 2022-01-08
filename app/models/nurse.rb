class Nurse < ApplicationRecord
    has_many :nurse_schedules
    has_many :schedules, through: :nurse_schedules
end
