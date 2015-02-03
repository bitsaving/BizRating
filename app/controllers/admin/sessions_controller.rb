class Admin::SessionsController < Devise::SessionsController
  before_action :load_user, only: :create

  layout 'admin'

  def create
    ## FIXME_NISH Refactor this code.
    if @user && @user.valid_password?(params[:user][:password])
      sign_in(:user, @user)
      redirect_to admin_businesses_path
    else
      redirect_to :new_admin_session, alert: 'invalid password'
    end
  end

  private
  def load_user
    @user = User.find_by(email: params[:user][:email])
    redirect_to :new_admin_session, alert: "Invalid email or password" unless @user && @user.admin?
  end
