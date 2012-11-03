# == Class: steam::steamcmd
#
# Trivial build for downloading and installing the steamcmd server module.
#
class steam::steamcmd {

  include steam::base
  include staging

  $steamcmd     = 'steamcmd.tar.gz'
  $steamcmd_url = "http://blog.counter-strike.net/wp-content/uploads/2012/04/${steamcmd}"

  $steamcmd_root = "${steam::base::home}/steamcmd"

  $staging_root = $steam::base::staging_root

  file { $steamcmd_root:
    ensure => directory,
    owner  => $steam::base::user,
    group  => $steam::base::group,
    mode   => '0755',
    backup => false,
    before => Staging::Deploy[$steamcmd],
  }

  staging::deploy { $steamcmd:
    source => $steamcmd_url,
    target => $steamcmd_root,
  }
}
