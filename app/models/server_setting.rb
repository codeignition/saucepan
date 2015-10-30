class ServerSetting
  include Mongoid::Document
  include Mongoid::Timestamps

  LDAP = "ldap"
  
  field :name, type: String, default: ""
  field :data, type: String, default: ""
  field :active, type: Boolean, default: false

  def get_ldap_settings
    server_setting = ServerSetting.where(name: LDAP, active: true).first
    if server_setting.blank?
      return nil
    end
    JSON.parse(server_setting.data)
  end

  def save_ldap_settings ldap_settings
    server_setting = ServerSetting.find_or_initialize_by(name: LDAP, active: true)
    server_setting.data = ldap_settings.to_json
    server_setting.save!
  end
end
