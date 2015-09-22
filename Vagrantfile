# -*- mode: ruby -*-
# vi: set ft=ruby :
unless Vagrant.has_plugin?("oscar")
  raise 'Oscar plugin not installed. First run: vagrant plugin install oscar'
end
Vagrant.configure('2', &Oscar.run(File.expand_path('../config', __FILE__))) if defined? Oscar
