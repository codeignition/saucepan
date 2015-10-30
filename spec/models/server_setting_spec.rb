require 'rails_helper'

RSpec.describe ServerSetting, :type => :model do

  describe "#server" do 
    it "should save ldapserver settings" do
      server_setting = {}
      server_setting["port"] = 389
      server_setting["server"] = "ldaps://localhost"
      server_setting["cn"] = "dc=co,dc=codeignition"

      server_setting_model = ServerSetting.create
      ldap_setting = server_setting_model.get_ldap_settings
      expect(ldap_setting).to eq nil

      server_setting_model.save_ldap_settings server_setting

      ldap_setting = server_setting_model.get_ldap_settings
      expect(ldap_setting["port"]).to eq server_setting["port"]
    end
  end
end
