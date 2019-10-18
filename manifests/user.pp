# @summary Create a single foreman user
#
# @param ensure
#   The basic state that the user should be in.
#
# @param username
#   The username
#
# @param group
#   The primary group of the user
#
# @param home
#   The home directory of the user
#
# @param password
#   An optional password for the user
#
# @param comment
#   An optional comment about the user. Usually the full name.
#
# @param ssh_authorized_keys
#   A list of authorized keys
#
# @example
#   foreman_simple_user::user { 'admin':
#     ssh_authorized_keys => [
#       {
#         key     => 'AAA..BBB',
#         type    => 'ssh-rsa',
#         comment => 'My First Key',
#       },
#     ],
#   }
#
define foreman_simple_user::user (
  Enum['present', 'absent', 'role'] $ensure              = 'present',
  String                            $username            = $title,
  String                            $group               = $title,
  String                            $home                = "/home/${title}",
  Optional[String]                  $comment             = undef,
  Optional[String]                  $password            = undef,
  Array[Hash]                       $ssh_authorized_keys = [],
) {
  user { $username:
    ensure         => $ensure,
    gid            => $group,
    home           => $home,
    managehome     => true,
    password       => $password,
    comment        => $comment,
    purge_ssh_keys => true,
  }

  unless defined("Group[${group}]") {
    group { $group:
      ensure => present,
    }
  }

  if $ssh_authorized_keys != [] {
    file { "${home}/.ssh":
      ensure => directory,
      owner  => $username,
      group  => $group,
      mode   => '0700',
    }

    $ssh_authorized_keys.each |$index, $key| {
      $comment = $index ? {
        0       => $key['comment'],
        default => "${key['comment']} - ${index}",
      }

      ssh_authorized_key { $comment:
        key  => $key['key'],
        type => $key['type'],
        user => $username,
      }
    }
  }
}
