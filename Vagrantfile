Vagrant::Config.run do |config|
  config.vm.box       = 'precise64'
  config.vm.box_url   = 'http://files.vagrantup.com/precise64.box'
  config.vm.host_name = 'spinuplabs-web-dev-box'

  config.vm.forward_port 3000, 3000

  config.vm.customize ["modifyvm", :id, "--natdnsproxy1", "off"]

  config.vm.customize ["modifyvm", :id, "--memory", 1024]

  config.vm.provision :puppet,
    :manifests_path => 'puppet/manifests',
    :module_path    => 'puppet/modules',
    :manifest_file  => 'default.pp'
end
