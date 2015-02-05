class Admin::SessionsController < Devise::SessionsController
  before_action :load_user, only: :create

  layout 'admin'

  def create
    ## FIXME_NISH Refactor this code.
    #FIXME_AB: You don't need to check for @user as first condition as you have checked it already in before filter
    if @user && @user.valid_password?(params[:user][:password])
      sign_in(:user, @user)
      redirect_to admin_businesses_path
    else
      #FIXME_AB: Please use proper messages
      redirect_to :new_admin_session, alert: 'invalid password'
    end
  end

  private
  #FIXME_AB: use proper indentation
  def load_user
    @user = User.find_by(email: params[:user][:email])
    redirect_to :new_admin_session, alert: "Invalid email or password" unless @user && @user.admin?
  end
end