class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
  end

  def show
    @schedule = Schedule.includes(:users => :user).find(params[:id])
  end

  def update
  end
end
