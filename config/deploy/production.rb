server '54.150.44.152', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/naomihara/.ssh/id_rsa'