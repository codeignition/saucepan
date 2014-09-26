require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do
  controller do
    def index
      render text: 'Hello world'
    end
  end

  describe 'force_profile_update' do
    it 'does not redirect if user is not logged' do
      get :index
      expect(response).to be_ok
    end

    it 'does not redirect if user is not a newcomer' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in create(:user)
      get :index
      expect(response).to be_ok
    end

    it 'does not redirect if user is a newcomer' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in create(:newcomer)
      get :index
      expect(response).to redirect_to(new_profile_path)
    end
  end
end
