class Group
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  has_many :users
end
