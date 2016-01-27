class Schedule < ApplicationRecord
  has_many :users, class_name: :ScheduleUser, dependent: :destroy
  has_many :roles, class_name: :ScheduleRole, dependent: :destroy

  def self.me(user)
    schedules = Schedule.includes(:users, :roles => {:role => :members}).where(Schedule.arel_table[:start_at].gteq(Time.zone.today))
    schedules
  end

  def registration_start_at
    read_attribute(:registration_start_at) || read_attribute(:created_at)
  end

  def registration_end_at
    read_attribute(:registration_end_at) || read_attribute(:start_at)
  end

  def register?
    registration_start_at <= Time.none.now < registration_end_at
  end
end
