# Create a single foreman user
#
# === Parameters:
#
# $ensure::          The basic state that the user should be in.
#
# $username::        The username
#
# $home::            The home directory of the user
#
# $password::        An optional password for the user
#
# $comment::         An optional comment about the user. Usually the full name.
#
# $authorized_keys:: A list of authorized keys
#
# === Usage:
#
#   foreman_simple_user::user { 'admin':
#     authorized_keys => [
#       {
#         key     => 'AAA..BBB',
#         type    => 'ssh-rsa',
#         comment => 'My First Key',
#       },
#     ],
#   }
#
define foreman_simple_user::user (
  Enum['present', 'absent', 'role'] $ensure          = 'present',
  String                            $username        = $title,
  String                            $home            = "/home/${title}",
  Optional[String]                  $comment         = undef,
  Optional[String]                  $password        = undef,
  Array[Hash]                       $authorized_keys = [],
) {
  user { $username:
    ensure         => $ensure,
    home           => $home,
    password       => $password,
    comment        => $comment,
    purge_ssh_keys => true,
  }

  $authorized_keys.each |$index, $key| {
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
