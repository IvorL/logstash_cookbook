#
# Cookbook:: logstash_cookbook
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Update the sources list
apt_update("update") do
  action :update
end

# Install Java version 8 for logstash
package("openjdk-8-jdk") do
  action :install
end

# Add a key for the elasticsearch repository
bash("add_elasticsearch_key") do
  code "wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -"
  action :run
end

# Add the elasticsearch repository to install logstash
apt_repository("elastic5") do
  uri "https://artifacts.elastic.co/packages/5.x/apt"
  distribution "stable"
  components ["main"]
  action :add
end


apt_update("update") do
  action :update
end

# Install logstash
package("logstash") do
  action :install
end

# Add the elasticsearch 6 repository to uograde logstash
apt_repository("elastic6") do
  uri "https://artifacts.elastic.co/packages/6.x/apt"
  distribution "stable"
  components ["main"]
  action :add
end

# Logstash must be upgraded from version 5 to 6. Installing 6 directly from the repository doesn't work
package("logstash") do
  action :upgrade
end

# Delete existing startup.options file on the VM
file("/usr/share/logstash/bin/startup.options") do
  action :delete
end

# Add a new startup.options file
template("/usr/share/logstash/bin/startup.options") do
  source "startup.options.erb"
end

# Delete existing jvm.options file on the VM
file("/etc/logstash/jvm.options") do
  action :delete
end

# Add a new jvm.options file
template("/etc/logstash/jvm.options") do
  source "jvm.options.erb"
end

# Delete existing logstash.yml file on the VM
file("/etc/logstash/logstash.yml") do
  action :delete
end

# Add a new logstash.yml file
template("/etc/logstash/logstash.yml") do
  source "logstash.yml.erb"
end

# Create a conf.d directory on the VM for the logstash.conf file
directory "/etc/logstash/conf.d" do
  action :create
end

# Add a logstash.conf file
template("/etc/logstash/conf.d/logstash.conf") do
  source "logstash.conf.erb"
end

# Enable and start the logstash service
service("logstash") do
  action [:enable, :start]
end
