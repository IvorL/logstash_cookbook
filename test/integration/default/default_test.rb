# # encoding: utf-8

# Inspec test for recipe logstash_cookbook::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package("openjdk-8-jdk") do
  it {should be_installed}
  its("version") {should eq "8u181-b13-0ubuntu0.16.04.1"}
end

describe package("logstash") do
  it {should be_installed}
  its("version") {should match /6\.4/}
end

describe service("logstash") do
  it {should be_enabled}
  it {should be_running}
end

describe file("/etc/logstash/jvm.options") do
  it {should exist}
end

describe file("/usr/share/logstash/bin/startup.options") do
  it {should exist}
end

describe file("/etc/logstash/logstash.yml") do
  it {should exist}
end

describe file("/etc/logstash/conf.d/logstash.conf") do
  it {should exist}
end

describe bash("wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -") do
  its('exit_status') { should eq 0 }
end
