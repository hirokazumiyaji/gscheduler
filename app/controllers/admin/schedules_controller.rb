class Admin::SchedulesController < AdminController
  def index
    @schedule = Schedule.includes(:users => :user).all
  end

  def create
    @schedule = Schedule.new(schedule_params)

    ApplicationRecord.transaction do
      @schedule.save!
      roles = params[:schedule][:role_ids].map do |role_id|
        ScheduleRole.new(schedule_id: @schedule.id, role_id: role_id)
      end
      ScheduleRole.import roles
    end
    redirect_to admin_schedules_path
  end

  def new
    @schedule = Schedule.new
    @roles = Role.includes(:members => :user).all.map do |role|
      ScheduleRole.new(role: role)
    end
  end

  def edit
    @schedule = Schedule.includes(:roles).find(params[:id])
    roles = Hash[*@schedule.roles.map{|role| [role.role_id, role]}.flatten]
    @roles = Role.include(:members => :user).all.map do |role|
      if roles.include?(role.id)
        roles[role.id].role = role
        roles[role.id]
      else
        ScheduleRole.new(schedule_id: @schedule.id, role: role)
      end
    end
  end

  def show
    @schedule = Schedule.includes(:roles, :users).find(params[:id])
    @users = User.all
    @roles = Role.includes(:members).all
  end

  def update
    ApplicatonRecord.transaction do
      Schedule.update!(schedule_params)
      if params[:schedule][:role_ids].any?
        ScheduleRole.where.not(role_id: params[:schedule][:role_ids]).delete_all
        role_ids = ScheduleRole.pluck :role_id
        roles = params[:schedule][:role_ids].select{|role_id| !role_ids.include?(role_id)}.map do
          ScheduleRole.new(schedule_id: params[:id], role_id: role_id)
        end
        ScheduleRole.import roles
      else
        ScheduleRole.where(schedule_id: params[:id]).delete_all
      end
    end
  end

  def destroy
    ApplicationRecord.transaction do
      Schedule.destroy!(params[:id])
    end

    redirect_to admin_schedules_path
  end

  private
    def schedule_params
      params.require(:schedule).permit(:title, :start_at, :end_at, :registration_start_at, :registration_end_at, :place, :note)
    end
end
