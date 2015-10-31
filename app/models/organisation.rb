class Organisation
  include Mongoid::Document
  field :user_id, type: Integer
  field :domain, type: String
end
