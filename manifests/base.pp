# == Class: steam::base
#
# Install the shared behavior for all steam server tools.
#
# == Parameters:
#
# * [*user*]  The user account used to run game servers. Default: steam
# * [*group*] The group used to run game servers. Default: steam
# * [*home*]  The directory containing server files. Be advised - this can get very large. Default: /srv/steam
#
# == Example:
#
# You probably won't need to directly include this class unless you need to
# override the default behavior. But if you do...
#
#   class { 'steam::server':
#     user  => 'steam-for-all',
#     group => 'steamadmins',
#     home  => '/var/lib/steamfiles',
#   }
#
# == Documentation
#
# * http://en.wikipedia.org/wiki/Half-Life_Dedicated_Server
#
# == Authors
#
# Adrien Thebo <adrien@somethingsinistral.net>
#
class steam::base($user = 'steam', $group = 'steam', $home = '/srv/steam') {

  include staging

  group { $group:
    ensure => present,
  }

  user { $user:
    ensure => present,
    managehome => true,
    home       => $home,
    gid        => $group,
  }

  file { $home:
    ensure => directory,
    owner  => $user,
    group  => $group,
    backup => false,
  }

  $staging_root = "${staging::path}/${module_name}"
}
