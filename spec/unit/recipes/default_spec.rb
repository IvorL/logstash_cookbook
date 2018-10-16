#
# Cookbook:: logstash_cookbook
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'logstash_cookbook::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it "should update the source list" do
      expect(chef_run).to update_apt_update("update")
    end

    it 'should install java 8' do
      expect(chef_run).to install_package("openjdk-8-jdk")
    end

    it 'should add the elastic stack to the sources list' do
      expect(chef_run).to run_bash('add_elasticsearch_key')
    end

    it "should add the elasticsearch repo (version 5)" do
      expect(chef_run).to add_apt_repository("elastic5")
    end

    it 'should install logstash' do
      expect(chef_run).to install_package("logstash")
    end

    it "should add the elasticsearch repo (version 6)" do
      expect(chef_run).to add_apt_repository("elastic6")
    end

    it "should upgrade logstash" do
      expect(chef_run).to upgrade_package("logstash")
    end

    it "should delete the existing startup.options file" do
      expect(chef_run).to delete_file("/usr/share/logstash/bin/startup.options")
    end

    it "should create a startup.options template file" do
      expect(chef_run).to create_template("/usr/share/logstash/bin/startup.options")
    end

    it "should delete the existing jvm.options file" do
      expect(chef_run).to delete_file("/etc/logstash/jvm.options")
    end

    it "should create a jvm.options template file" do
      expect(chef_run).to create_template("/etc/logstash/jvm.options")
    end

    it "should delete the existing logstash.yml file" do
      expect(chef_run).to delete_file("/etc/logstash/logstash.yml")
    end

    it "should create a logstash.yml template file" do
      expect(chef_run).to create_template("/etc/logstash/logstash.yml")
    end

    it "should make a conf.d directory for the logstash.conf file" do
      expect(chef_run).to create_directory("/etc/logstash/conf.d")
    end

    it "should create a logstash.conf template file" do
      expect(chef_run).to create_template("/etc/logstash/conf.d/logstash.conf")
    end

    it "should enable logstash" do
      expect(chef_run).to enable_service("logstash")
    end

    it "should start logstash" do
      expect(chef_run).to start_service("logstash")
    end
  end
end
