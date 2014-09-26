if ENV['RAILS_ENV'] == 'development'
  %w( admin labour ).each do |name|
    Group.find_or_create_by(name: name, applications: [application])
  end

  User.create(email: 'shobhit@codeignition.co', password: 'shobhit@123')
end

