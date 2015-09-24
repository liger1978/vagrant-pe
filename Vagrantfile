# -*- mode: ruby -*-
# vi: set ft=ruby :
unless Vagrant.has_plugin?("oscar")
  raise 'Oscar plugin not installed. First run: vagrant plugin install oscar'
end
Vagrant.configure("2") do |config|
	if Vagrant.has_plugin?("vagrant-hostmanager")
		config.hostmanager.enabled = true
		config.hostmanager.manage_host = true
		config.hostmanager.ignore_private_ip = false
		config.hostmanager.include_offline = true
	end
end
Vagrant.configure("2") do |config|
  config.vm.box = 'centos7'
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
	config.cache.enable :yum
  end
end
Vagrant.configure('2', &Oscar.run(File.expand_path('../config', __FILE__))) if defined? Oscar