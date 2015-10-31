require 'rails_helper'

RSpec.describe SetupController, type: :controller do
  let(:valid_attributes) { attributes_for :user }
  let(:invalid_attributes) { {} }
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns a new user" do
      get :index

      expect(assigns(:user)).to be_a_new(User)
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

        it "creates a new organisation" do
          count = Organisation.count
          post :create, {:user => valid_attributes}, valid_session
          expect(Organisation.count).to eq count + 1

        end

        it "assigns a newly created user as @user" do
          post :create, {:user => valid_attributes}, valid_session
          expect(assigns(:user)).to be_a(User)
          expect(assigns(:user)).to be_persisted
        end

      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved user as @user" do
          post :create, {:user => invalid_attributes}, valid_session
          expect(assigns(:user)).to be_a_new(User)
        end

        it "re-renders the 'index' template" do
          post :create, {:user => invalid_attributes}, valid_session
          expect(response).to render_template("index")
        end
      end
    end
  end
end
