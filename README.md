# logstash_cookbook

Logstash is a data processing pipeline capable of storing and manipulating data from multiple sources, such as AWS EC2 instances. It can be used in conjunction with FileBeat, MetricBeat, Elasticsearch and Kibana, which are open-source projects created by the Elastic company in order to monitor sytems.

When Filebeat and MetricBeat are installed on a machine, they pass log and system metric data to Logstash.

The recipe contained within this Cookbook provides the necessary provisioning steps for installing Logstash and its dependencies on a virtual machine. The unit and integration tests created using ChefSpec and InSpec test the provisioning recipe to ensure that the necessary repositories have been added, required packages have been installed, folders and files have been added, and that the packages are the correct version.

In order to run the tests on the Cookbook, follow these steps:

1. Clone the repository for this Cookbook.
2. From the terminal (inside the cloned repository), run the following command to perform the unit tests:
  ```
  chef exec rspec spec
  ```
3. When the unit tests have passed, run the following command to perform the integration tests:
```
kitchen test
```
