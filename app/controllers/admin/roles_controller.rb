class Admin::RolesController < AdminController
  def index
    @roles = Role.includes(:members => :user).all
  end

  def create
    @role = Role.new(role_params)

    @role.save

    redirect_to @role
  end

  def new
    @role = Role.new
    @users = User.all
  end

  def edit
    @role = Role.includes(:members => :user).find(params[:id])
  end

  def show
    @role = Role.includes(:members => :user).find(params[:id])
  end

  def update
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
