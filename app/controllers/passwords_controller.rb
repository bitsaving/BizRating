class PasswordsController < ApplicationController

  before_filter :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_with_password(user_params)
      sign_in @user, :bypass => true
      redirect_to :categories_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.required(:user).permit(:password, :password_confirmation, :current_password)
  end
end