# Ensure foreman users are present on the system
#
# === Parameters:
#
# $users:: The hash of users
#
# === Usage:
#
#   include ::foreman_simple_user
#
class foreman_simple_user (
  Hash[String, Hash] $users = $::foreman_users,
) {
  $users.each |$username, $user| {
    foreman_simple_user::user { $username:
      home                => $user['home'],
      password            => $user['password'],
      comment             => $user['fullname'],
      ssh_authorized_keys => $user['ssh_authorized_keys'],
    }
  }
}
