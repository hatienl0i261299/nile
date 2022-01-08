class NurseSchedule < ApplicationRecord
    belongs_to :schedule
    belongs_to :nurse
end
