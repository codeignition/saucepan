class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
  end

  def new
    redirect_to edit_profile_path unless current_user.newcomer?
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(profile_params)
        format.html { redirect_to root_path, notice: 'Profile was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def profile_params
      params[:user].permit(:email, :password, :password_confirmation, :key)
    end

    def set_user
      @user = current_user
    end
end
