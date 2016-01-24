class ScheduleUser < ApplicationRecord
  belongs_to :schedule
  belongs_to :user

  enum status: {unregist: 0, attendance: 1, absence: 2, undecided: 3}
end
