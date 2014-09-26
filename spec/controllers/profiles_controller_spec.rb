require 'rails_helper'

RSpec.describe ProfilesController, :type => :controller do
  let(:valid_attributes) do
    { email: generate(:email), key: 'key' }
  end

  login_user

  describe "GET show" do
    it "assigns the requested user as @user" do
      get :show
      expect(assigns(:user)).to eq(User.last)
    end
  end

  describe "GET new" do
    it "assigns a current user as @user" do
      get :new
      expect(assigns(:user)).to eq(User.last)
    end

    it "should redirect to edit for old user" do
      user = User.last
      user.update(:sign_in_count => 2)
      get :new
      expect(response).to redirect_to(edit_profile_path)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      get :edit
      expect(assigns(:user)).to eq(User.last)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user profile" do
        User.last.update(key: 'dsdsd')
        put :update, {:user => valid_attributes}
        expect(User.last.key).to eq(valid_attributes[:key])
      end

      it "assigns the requested user as @user" do
        put :update, { :user => valid_attributes}
        expect(assigns(:user)).to eq(User.last)
      end

      it "redirects to the user" do
        put :update, { :user => valid_attributes}
        expect(response).to redirect_to(profile_path)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        put :update, {:user => { :password => '1'}}
        expect(assigns(:user)).to eq(User.last)
      end

      it "re-renders the 'edit' template" do
        put :update, {:user => { :password => '1'}}
        expect(response).to render_template("edit")
      end
    end
  end
end
