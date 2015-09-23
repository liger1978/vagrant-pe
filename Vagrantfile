# -*- mode: ruby -*-
# vi: set ft=ruby :
unless Vagrant.has_plugin?("oscar")
  raise 'Oscar plugin not installed. First run: vagrant plugin install oscar'
end
unless Vagrant.has_plugin?("vagrant-hostmanager")
  raise 'Hostmanager plugin not installed. First run: vagrant plugin install vagrant-hostmanager'
end
Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true
end
Vagrant.configure('2', &Oscar.run(File.expand_path('../config', __FILE__))) if defined? Oscar