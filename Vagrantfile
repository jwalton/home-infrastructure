# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "opscode-ubuntu-12.04"
  config.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.10.11"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Install the latests version of chef
  config.omnibus.chef_version = :latest
  #config.omnibus.chef_version = '10.26.0'

  # Use the Berksfile
  config.berkshelf.enabled = true
  # config.berkshelf.berksfile_path = Pathname(__FILE__).dirname.join('chef', 'Berksfile')

  chef_json = JSON.parse(File.read(Pathname(__FILE__).dirname.join('nodes', 'default.json')))
  chef_json.merge!({
      :instance_role => "vagrant",
      :set_fqdn => "vagrant-#{`whoami`.strip()}"
  })

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
      chef.data_bags_path = "data_bags"
      chef.roles_path = "roles"
      chef.cookbooks_path = "." # Load from Berksfile.
      for recipe in chef_json["run_list"] do
          chef.add_recipe(recipe)
      end

      # Custom JSON node attributes for chef
      chef.json = chef_json
  end
end
