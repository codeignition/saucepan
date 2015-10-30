class SessionsController < Devise::SessionsController
  def new
    user = User.first
    if user.present?
      super
    else
      redirect_to "/setup"
    end
  end
end