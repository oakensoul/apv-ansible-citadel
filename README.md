# apv-ansible-citadel
Atlas, Packer, Vagrant, Ansible Citadel

This project contains the scripts required to build Ubuntu LTS base boxes with Ansible, Boto, AWS CLI and latest
updates from apt-get. This project should work successfully on any Linux, Mac or Windows environment capable of running
Vagrant and VirtualBox.

## Usage
The output of this project is a collection of Vagrant Boxes. To use one of the
Boxes for one of your projects, simply add the following to your Vagrantfile.

```bash
  # Use Ansible Citadel based on ubuntu/trusty64
  config.vm.box = "oakensoul/ansible-citadel-trusty64"

  # Use Ansible Citadel based on hashicorp/precise64
  config.vm.box = "oakensoul/ansible-citadel-precise64"
```

## Specific Contents of this Box



## Manual Packer Push
The box is set to automatically update whenever an update to the master branch occurs. However, for testing, or if
you would like to push a build manually, execute the following command:
````
$ packer push ubuntu-trusty64.json
````

## Contributing
* [Getting Started](https://github.com/oakensoul/trunk/blob/master/CONTRIBUTING.md)
* [Bug Reports](https://github.com/oakensoul/trunk/blob/master/CONTRIBUTING.md#bug-reports)
* [Feature Requests](https://github.com/oakensoul/trunk/blob/master/CONTRIBUTING.md#feature-requests)
* [Pull Requests](https://github.com/oakensoul/trunk/blob/master/CONTRIBUTING.md#pull-requests)

# LICENSE
This repository is licensed using the Apache 2.0 License.

Copyright (C) 2015 [Robert Gunnar Johnson Jr.](https://github.com/oakensoul)
Apache License, Version 2.0, January 2004, http://www.apache.org/licenses/
