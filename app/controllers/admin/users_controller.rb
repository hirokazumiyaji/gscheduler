class Admin::UsersController < AdminController
  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    @user.sign_in_id = @user.uuid

    if @user.save
      redirect_to admin_users_url
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_users_url
    else
      render 'edit'
    end
  end

  def destroy
    ApplicationRecord.transaction do
      User.destroy(params[:id])
      ScheduleUser.destroy_all(user_id: params[:id])
      RoleMember.destroy_all(user_id: params[:id])
    end

    redirect_to admin_users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
