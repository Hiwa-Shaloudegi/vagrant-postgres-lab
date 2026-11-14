Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.hostname = "ubunto-jammy64"

  config.vm.network "forwarded_port",
    guest: 5432,
    host: 5433,
    host_ip: "127.0.0.1"

  config.vm.provider "virtualbox" do |vm|
    vm.name = "simple_postgres_vm"
    vm.memory = 2048
    vm.cpus = 2
  end

  config.vm.provision "shell", path: "bootstrap.sh"
end