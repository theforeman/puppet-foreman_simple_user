[![Build Status](https://travis-ci.org/ekohl/puppet-foreman_simple_user.svg?branch=master)](https://travis-ci.org/ekohl/puppet-foreman_simple_user)

# Foreman Simple User module for Puppet

Every host in The Foreman has an owner. This can be a user or a group. This
module enables you to ensure the user exists with their SSH keys. This makes it
easy to get your infrastructure up and running with centralized logins like
LDAP.

This requires use of the Foreman ENC and
[#4290](https://github.com/theforeman/foreman/pull/4290).

# Usage

Include the top level `foreman_simple_user` class to create the users.

    include ::foreman_simple_user

# Contributing

* Fork the project
* Commit and push until you are happy with your contribution
* Send a pull request with a description of your changes

See the CONTRIBUTING.md file for much more information.

# More info

See https://theforeman.org or at #theforeman irc channel on freenode

Copyright (c) 2017 Ewoud Kohl van Wijngaarden

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
