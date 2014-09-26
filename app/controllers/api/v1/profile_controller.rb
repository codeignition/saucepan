module Api::V1
  class ProfileController < ApplicationController
    doorkeeper_for :all
    respond_to :json

    def index
      user =  User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      render json: user
    end
  end
end
