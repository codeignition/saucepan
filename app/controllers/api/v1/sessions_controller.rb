module Api::V1
  class SessionsController < ApplicationController
    protect_from_forgery with: :null_session
    skip_before_action :force_profile_update

    doorkeeper_for :all
    respond_to :json

    def destroy
      doorkeeper_token.revoke
      render json: {sign_out_url: service_sign_out_url}
    end

    private
    def current_user
      logger.debug doorkeeper_token.inspect
      @current_user ||= User.find_by_id(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
  end
end
