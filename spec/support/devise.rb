module DeviseMacros
  def login_user(user_type = :user)
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in (@user = FactoryGirl.create(user_type))
    end
  end
end
