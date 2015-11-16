class Organisation
  include Mongoid::Document
  field :user_id, type: Integer
  field :domain, type: String

  #LDAP Settings
  field :ldap_server_address, type: String
  field :ldap_dn, type: String
  field :ldap_user, type: String
  field :ldap_password, type: String

end
