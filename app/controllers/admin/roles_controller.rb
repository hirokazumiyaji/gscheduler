class Admin::RolesController < AdminController
  def index
    @roles = Role.includes(:members => :user).all
  end

  def create
    @role = Role.new(role_params)

    ApplicationRecord.transaction do
      @role.save!
      role_members = params[:role][:member_ids].map do |member_id|
        RoleMember.new(role_id: @role.id, user_id: member_id)
      end
      RoleMember.import role_members
    end

    redirect_to admin_roles_path
  end

  def new
    @role = Role.new
    @role_members = User.all.map do |user|
      RoleMember.new(user: user)
    end
  end

  def edit
    @role = Role.includes(:members).find(params[:id])
    member_users = Hash[*@role.members.map{|member| [member.user_id, member]}.flatten]
    @role_members = User.all.map do |user|
      if member_users.include?(user.id)
        member_users[user.id].user = user
        member_users[user.id]
      else
        RoleMember.new(role_id: @role.id, user: user)
      end
    end
  end

  def show
    @role = Role.includes(:members => :user).find(params[:id])
  end

  def update
    ApplicationRecord.transaction do
      Role.update!(role_params)
      RoleMember.where.not(user_id: params[:role][:member_ids]).delete_all
      user_ids = RoleMember.pluck :user_id
      role_members = params[:role][:member_ids].select{|member_id| !user_ids.include?(member_id)}.map do |member_id|
        RoleMember.new(role_id: params[:id], user_id: member_id)
      end
      RoleMember.import role_members
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy

    redirect_to admin_roles_path
  end

  private
    def role_params
      params.require(:role).permit(:name)
    end
end
