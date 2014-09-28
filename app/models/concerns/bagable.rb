module Bagable
  extend ActiveSupport::Concern
  included do
    before_save do |object|
      update_data_bag object if ENV['BAGABLE'] == 'true'
    end
  end

  def update_data_bag object
    id   = object.class.to_s.downcase

    Chef::Config.from_file(File.join(ENV['HOME'], '.chef', 'knife.rb'))

    begin
      Chef::REST.new(Chef::Config[:chef_server_url]).get_rest("data/#{bagname}")
    rescue Net::HTTPServerException => e
      if e.response.code == "404"
        puts("INFO: Creating a new data bag item")
        Chef::REST.new(Chef::Config[:chef_server_url]).post_rest("data", {name: bagname})
      else
        puts("ERROR: Received an HTTPException of type " + e.response.code)
        raise
      end
    end

    begin
      items = Chef::REST.new(Chef::Config[:chef_server_url]).get_rest("data/#{bagname}/#{id}")
      Chef::REST.new(Chef::Config[:chef_server_url]).put_rest("data/#{bagname}/#{id}", items.merge(data))
    rescue Net::HTTPServerException => e
      if e.response.code == "404"
        Chef::REST.new(Chef::Config[:chef_server_url]).post_rest("data/#{bagname}/", data.merge({id: id}))
      else
        puts("ERROR: Received an HTTPException of type " + e.response.code)
        raise
      end
    end
  end

  def bagname
    'sshadmin'
  end

  def data
    {}
  end
end
