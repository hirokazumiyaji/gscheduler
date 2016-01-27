class ScheduleRole < ApplicationRecord
  belongs_to :schedule
  belongs_to :role, foreign_key: :role_id
end
