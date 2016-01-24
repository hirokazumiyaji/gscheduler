class Schedule < ApplicationRecord
  has_many :users, class_name: :ScheduleUser, dependent: :destroy
end
