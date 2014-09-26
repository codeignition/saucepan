require 'rails_helper'

RSpec.describe GroupsController, :type => :controller do
  let(:group) { create :group }
  let(:valid_attributes) { attributes_for :group }
  let(:invalid_attributes) { {name: nil} }
  let(:valid_session) { {} }

  login_user :admin

  describe "GET index" do
    it "assigns all groups as @groups" do
      group = create :group
      get :index, {}, valid_session
      expect(assigns(:groups).to_a).to eq([group])
    end
  end

  describe "GET show" do
    it "assigns the requested group as @group" do
      get :show, {:id => group.to_param}, valid_session
      expect(assigns(:group)).to eq(group)
    end
  end

  describe "GET new" do
    it "assigns a new group as @group" do
      get :new, {}, valid_session
      expect(assigns(:group)).to be_a_new(Group)
    end
  end

  describe "GET edit" do
    it "assigns the requested group as @group" do
      get :edit, {:id => group.to_param}, valid_session
      expect(assigns(:group)).to eq(group)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Group" do
        expect {
          post :create, {:group => valid_attributes}, valid_session
        }.to change(Group, :count).by(1)
      end

      it "assigns a newly created group as @group" do
        post :create, {:group => valid_attributes}, valid_session
        expect(assigns(:group)).to be_a(Group)
        expect(assigns(:group)).to be_persisted
      end

      it "redirects to the created group" do
        post :create, {:group => valid_attributes}, valid_session
        expect(response).to redirect_to(Group.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved group as @group" do
        post :create, {:group => invalid_attributes}, valid_session
        expect(assigns(:group)).to be_a_new(Group)
      end

      it "re-renders the 'new' template" do
        post :create, {:group => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested group" do
        put :update, {:id => group.to_param, :group => new_attributes}, valid_session
        group.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested group as @group" do
        put :update, {:id => group.to_param, :group => valid_attributes}, valid_session
        expect(assigns(:group)).to eq(group)
      end

      it "redirects to the group" do
        put :update, {:id => group.to_param, :group => valid_attributes}, valid_session
        expect(response).to redirect_to(group)
      end
    end

    describe "with invalid params" do
      it "assigns the group as @group" do
        put :update, {:id => group.to_param, :group => invalid_attributes}, valid_session
        expect(assigns(:group)).to eq(group)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => group.to_param, :group => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested group" do
      group = Group.create! valid_attributes
      expect {
        delete :destroy, {:id => group.to_param}, valid_session
      }.to change(Group, :count).by(-1)
    end

    it "redirects to the groups list" do
      delete :destroy, {:id => group.to_param}, valid_session
      expect(response).to redirect_to(groups_url)
    end
  end

  describe "DELETE remove_group" do
    it "should remove given user form the group" do
      user = create :user
      delete :remove_user, {id: group.id, user_id: user.id}
      user.reload
      expect(user.groups).to eq([])
    end
  end

  describe "POST add_group" do
    it "add users to group" do
      user = create :user
      post :add_user, {id: group.id , user_id: user.id}
      user.reload
      expect(user.groups).to eq([group])
    end
  end
end
