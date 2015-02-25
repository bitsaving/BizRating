class Admin::UsersController < Admin::BaseController

  before_action :load_user, only: :update_status

  def index
    @q =  User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(20)
  end

  def update_status
    if @user.set_status!(params[:userActive])
      render json: [@user.active]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

    def load_user
      @user = User.find_by(id: params[:id])
      redirect_to admin_users_path, alert: 'No user found' unless @user
    end

end