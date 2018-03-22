require 'serverspec'
require 'net/ssh'

set :backend, :ssh

host = ENV['TARGET_HOST']

options = Net::SSH::Config.for(host)
options[:user] ||= 'jenkins'

set :host, options[:host_name] || host
set :ssh_options, options
set :disable_sudo, true
