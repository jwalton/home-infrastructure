root = File.absolute_path(File.dirname(__FILE__))

file_cache_path           "/tmp/chef-solo"
data_bag_path             "/var/chef/data_bags"
encrypted_data_bag_secret "/var/chef-solo/data_bag_key"
cookbook_path             [ root + '/cookbooks' ]
role_path                 root + "/roles"
