# Define the parameters

class httpd (
  # timeout is a reserved puppet variable
  $timeout_seconds      = '60',
  $keepalive            = 'Off',
  $maxkeepaliverequests = '100',
  $keepalivetimeout     = '15',
  $startservers         = '4',
  $minspareservers      = '2',
  $maxspareservers      = '8',
  $serverlimit          = '256',
  $maxclients           = '256',
  $maxrequestsperchild  = '4000',
  $minsparethreads      = '25',
  $maxsparethreads      = '75',
  $threadsperchild      = '32',
  $listen               = ['80'],
  $namevirtualhost      = [],
  $extendedstatus       = 'Off',
  $user                 = 'root',
  $group                = 'root',
  $serveradmin          = 'root@localhost',
  $servername           = undef,
  $usecanonicalname     = 'Off',
  $documentroot         = '/var/www/html',
  $serversignature      = 'On',
  $sslconf              = '/etc/httpd/conf.d',
  $logrotate_files      = '/var/log/httpd/*log',
  $logrotate_freq       = false,
  $logrotate_opts       = ['missingok', 'notifempty', 'sharedscripts', 'delaycompress',],
  $service_restart      = '/sbin/service httpd reload',) {
  include 'httpd::install'

  # Replace welcome.conf for SSL
  httpd::file { '$sslconf/welcome.conf': source => "puppet:///modules/srechallenge/files/welcome.conf", }
}

# Verify http running and restart
service { 'httpd':
  ensure    => running,
  enable    => true,
  restart   => $::service_restart,
  hasstatus => true,
  require   => Package['httpd'],
}

# Verify mod_ssl installed
package { '$sslconf/mod_ssl':
  ensure => installed,
  notify => Service['httpd'],
}

# Verify ssl.conf installed
httpd::file { '$sslconf/ssl.conf':
  ensure  => "present",
  source  => "puppet:///modules/srechallenge/files/ssl.conf",
  require => Package['mod_ssl'],
}

