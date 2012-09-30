# == Class: steam::hlds
#
# Install the Steam Half Life Dedicated Server tool, to manage your
# mission critical dedicated servers.
#
# == Example:
#
#   include steam::hlds
#   class { 'sysadmin': # Wouldn't this be awesome?
#     ensure   => 'killing zombies',
#     duration => forever,
#     require  => Class['steam::hlds'],
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
class steam::hlds {

  include steam::base
  include staging

  # HLDS and steamcmd can't be in the same dir
  $hlds_root = "${steam::base::home}/hlds"

  $updatetool        = 'hldsupdatetool.bin'
  $updatetool_url    = "http://storefront.steampowered.com/download/${updatetool}"

  $staging_path      = "${staging::path}/${module_name}"

  $updatetool_source = "${staging_path}/${updatetool}"
  $updatetool_dest   = "${hlds_root}/${updatetool}"
  $steam_bin         = "${hlds_root}/steam"

  file { $hlds_root:
    ensure => directory,
    owner  => $user,
    group  => $group,
    backup => false,
  }

  staging::file { $updatetool:
    source => $updatetool_url,
  }

  # Ensure that the update
  file { $updatetool_dest:
    ensure => present,
    mode   => '755',
    owner  => 'steam',
    group  => 'steam',
    source => $updatetool_source,
  }

  exec { 'unpack hlds steam tool':
    command   => "/bin/echo -e 'yes' | ${updatetool_dest}",
    cwd       => $home,
    path      => '/usr/bin:/bin',
    user      => $user,
    group     => $group,
    require   => File[$updatetool_dest],
    creates   => $steam_bin,
    logoutput => on_failure,
    provider  => shell,
  }
}
