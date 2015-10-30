class SetupController < ApplicationController
  def index
    user = User.first
    if user.present?
      redirect_to "/"
    end
    print "hello"
  end
end
