class GroupController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def show
    @user = User.where(group_id: nil)
  end

  def remove_user
    respond_to do |format|
      if params[:user_id].nil?
        format.html { redirect_to @group, notice: 'User not given.' }
      else
        User.find(params[:user_id]).update(group: nil)
        format.html { redirect_to @group, notice: 'User was successfully removed.' }
      end
    end
  end

  def add_user
    respond_to do |format|
      User.find(params[:user_id]).update(group: params[:id])
      format.html{redirect_to @group, notice: 'User was Added Successfully'}
    end
  end

  private
  def set_group
    @group = Group.find(params[:id])
  end
end
