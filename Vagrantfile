ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

Vagrant.configure("2") do |config|
    config.vm.define "admin" do |admin|
   # admin.vm.network :private_network, type: "static", subnet: "172.20.128.0/24"
    admin.vm.network :private_network, ip: "192.168.10.10", netmask: 24
    admin.vm.network "forwarded_port", guest: 80, host: 80
    admin.vm.network "forwarded_port", guest: 443, host: 443
    admin.vm.provider "docker" do |admin|
    admin.build_dir = "."
    admin.has_ssh = true
    admin.privileged = true
    admin.create_args = ["-v", "/sys/fs/cgroup:/sys/fs/cgroup:ro"]
            admin.name = "admin"
   end
  end
end

  clients=2
  (1..clients).each do |i|
    Vagrant.configure("2") do |config|
    config.vm.define "client#{i}" do |client|
      client.vm.network "private_network", type: "static", ip: "192.168.10.1#{i}"
      client.vm.provider "docker" do |client|
      client.build_dir = "."
      client.has_ssh = true
      client.privileged = true
      client.create_args = ["-v", "/sys/fs/cgroup:/sys/fs/cgroup:ro"]
        client.name = "client#{i}"
      end
    end
  end
end
