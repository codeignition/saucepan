require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  let(:valid_attributes) { {
    email: "a@atom.com",
    password: 'test123456',
    password_confirmation: 'test123456',
    login_name: 'shobit',
    name: 'Shobhit',
    user_id: 2001
  }}
  let(:invalid_attributes) { {} }
  let(:valid_session) { {} }

  describe "GET index" do
    context "When user logged in" do
      login_user :admin

      it "assigns all users as @users" do
        user = User.create! valid_attributes
        get :index
        expect(assigns(:users)).to eq(User.all)
      end
    end
  end

  describe "GET show" do
    context "When user logged in" do
      login_user :admin

      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        get :show, {:id => user.to_param}, valid_session
        expect(assigns(:user)).to eq(user)
      end
    end
  end

  describe "GET new" do
    context "When user logged in" do
      login_user :admin

      it "assigns a new user as @user" do
        get :new, {}, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end

  describe "GET edit" do
    context "When user logged in" do
      login_user :admin

      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        get :edit, {:id => user.to_param}, valid_session
        expect(assigns(:user)).to eq(user)
      end
    end
  end

  describe "POST create" do
    context "When user logged in" do
      login_user :admin

      describe "with valid params" do
        it "creates a new User" do
          expect {
            post :create, {:user => valid_attributes}, valid_session
          }.to change(User, :count).by(1)
        end

        it "assigns a newly created user as @user" do
          post :create, {:user => valid_attributes}, valid_session
          expect(assigns(:user)).to be_a(User)
          expect(assigns(:user)).to be_persisted
        end

        it "redirects to the created user" do
          post :create, {:user => valid_attributes}, valid_session
          expect(response).to redirect_to(User.last)
        end
        it "increments the user_id count in organisation" do
          Organisation.create(user_id: 2000, domain: 'codeignition.co')
          user_id = Organisation.first.user_id
          post :create, :user => valid_attributes
          expect(Organisation.first.user_id).to eq(user_id + 1)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved user as @user" do
          post :create, {:user => invalid_attributes}, valid_session
          expect(assigns(:user)).to be_a_new(User)
        end

        it "re-renders the 'new' template" do
          post :create, {:user => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end
  end

  describe "PUT update" do
    context "When user logged in" do
      login_user :admin

      describe "with valid params" do
        it "updates the requested user" do
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => {ssh_key: 'Minie'}}, valid_session
          user.reload
          expect(user.ssh_key).to eq('Minie')
        end

        it "assigns the requested user as @user" do
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
          expect(assigns(:user)).to eq(user)
        end

        it "redirects to the user" do
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
          expect(response).to redirect_to(user)
        end
      end

      describe "with invalid params" do
        it "assigns the user as @user" do
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => invalid_attributes}, valid_session
          expect(assigns(:user)).to eq(user)
        end

        it "re-renders the 'edit' template" do
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => {password: '1'}}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end
  end

  describe "DELETE destroy" do
    context "When user logged in" do
      login_user :admin

      it "destroys the requested user" do
        user = User.create! valid_attributes
        expect {
          delete :destroy, {:id => user.to_param}, valid_session
        }.to change(User, :count).by(-1)
      end

      it "redirects to the users list" do
        user = User.create! valid_attributes
        delete :destroy, {:id => user.to_param}, valid_session
        expect(response).to redirect_to(users_url)
      end
    end
  end
end
