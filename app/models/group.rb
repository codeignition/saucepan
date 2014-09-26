class Group
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  has_and_belongs_to_many :users
  validates_presence_of :name
end
