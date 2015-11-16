class SetupController < ApplicationController

  def index
    user = User.first
    if user.present?
      redirect_to "/"
    else
      @user = User.new;
    end
  end

  def create
    @user = User.new(user_params)
    @user.admin = true
    @user.user_id = 2000
    @organisation = Organisation.create(user_id: @user.user_id, domain: params[:domain])
    respond_to do |format|
      if @user.save
        format.html { redirect_to new_user_session_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :index }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_params
    params[:user].permit(:email, :password, :password_confirmation, :ssh_key, :name, :login_name, :user_id, :group_ids => [])
  end
end
