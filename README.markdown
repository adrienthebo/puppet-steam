puppet-steam
============

Reduce your productivity by 500% by using Puppet to install Steam dedicated
servers! This module will bootstrap the necessary components to allow you to
install servers.

Synopsis
--------

    include steam::hlds
    include steam::steamcmd
    # LET THE PROCRASTINATION BEGIN

Requirements
------------

You'll need Nan Liu's glorious [puppet-staging](https://github.com/nanliu/puppet-staging)
module to download the relevant files.

In addition, steam games can burn a HUGE amount of space. This fun little fact
was discovered when the author tried installing Left 4 Dead 2 on his VPS to
discover that it had completely filled his 20 GB drive.

TODO
----

### Defined types for installing HLDS games automatically.

This is non-trivial because the insane behavior of the `steam` command may
require multiple passes to actually do what you want.

Steam Server Documentation
--------------------------

  * [Steam support - setting up a standalone dedicated server](https://support.steampowered.com/kb_article.php?ref=6758-TCMF-2234)
  * [steamcmd - Valve Developer Community](https://developer.valvesoftware.com/wiki/SteamCMD)

