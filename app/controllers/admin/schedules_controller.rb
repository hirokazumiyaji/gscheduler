class Admin::SchedulesController < AdminController
  def index
    @schedule = Schedule.includes(:users => :user).all
  end

  def create
    @schedule = Schedule.new(schedule_params)

    @schedule.save
    redirect_to @schedule
  end

  def new
    @schedule = Schedule.new
    @roles = Role.includes(:members => :user).all
  end

  def edit
    @schedule = Schedule.includes(:roles, :users).find(params[:id])
    @users = User.all
    @roles = Role.includes(:members).all
  end

  def show
    @schedule = Schedule.includes(:roles, :users).find(params[:id])
    @users = User.all
    @roles = Role.includes(:members).all
  end

  def update
  end

  def destroy
    ApplicationRecord.transaction do
      Schedule.destroy!(params[:id])
    end

    redirect_to admin_schedules_path
  end

  private
    def schedule_params
      params.require(:schedule).permit()
    end
end
