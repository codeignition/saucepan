require 'rails_helper'

RSpec.describe GroupController, :type => :controller do
  let(:group) { create :group }
  login_user :admin

  describe "GET show" do
    it "assigns the requested group as @group" do
      get :show, {:id => group.id}
      expect(assigns(:group)).to eq(group)
    end
  end

  describe "DELETE remove_group" do
    it "removes the user from @group" do
      delete :remove_user, {:id => group.id}
      expect(assigns(:group)).to eq(group)
    end

    it "redirects to the group" do
      delete :remove_user, {:id => group.id}
      expect(response).to redirect_to(group)
    end

    it "should remove given user form the group" do
      user = create :user
      delete :remove_user, {id: group.id, user_id: user.id}
      user.reload
      expect(user.group).to be_nil
    end
  end

  describe "POST add_group" do
    it "add users to group" do
      user = create :user
      post :add_user, {id: group.id , user_id: user.id}
      user.reload
      expect(user.group).to eq(group)
    end
  end
end

