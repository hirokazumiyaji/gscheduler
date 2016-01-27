class PagesController < ApplicationController
  def index
    @user = User.new(id: 1, name: 'user1', email: 'user1@example.com')
    @schedules = Schedule.me(@user)
  end
end
