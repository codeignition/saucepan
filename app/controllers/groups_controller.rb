class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :add_user, :remove_user]
  before_action :set_user,  only: [:add_user, :remove_user]

  def index
    @groups = Group.all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_user
    @user.groups.delete(@group)
    @user.save
    respond_to do |format|
      format.html { redirect_to @group, notice: 'User was successfully removed.' }
    end
  end

  def add_user
    @user.groups.push(@group)
    @user.save
    respond_to do |format|
      format.html{redirect_to @group, notice: 'User was Added Successfully'}
    end
  end

  private
  def set_group
    @group = Group.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def group_params
    params[:group].permit(:name,:query)
  end
end
