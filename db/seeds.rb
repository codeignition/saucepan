%w( admin labour ).each do |name|
  Group.find_or_create_by(name: name)
end

User.create(email: 'shobhit@codeignition.co', password: 'shobhit@123')
