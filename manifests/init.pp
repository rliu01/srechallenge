# Define the parameters
include apache
include firewall

class httpd (
  # timeout is a reserved puppet variable
  $timeout_seconds  = '60',
  $listen           = ['80'],
  $namevirtualhost  = [],
  $extendedstatus   = 'Off',
  $user             = 'root',
  $group            = 'root',
  $serveradmin      = 'root@localhost',
  $servername       = undef,
  $usecanonicalname = 'Off',
  $documentroot     = '/var/www/html',
  $serversignature  = 'On',
  $sslconf          = '/etc/httpd/conf.d',
  $logrotate_files  = '/var/log/httpd/*log',
  $logrotate_freq   = false,
  $logrotate_opts   = [
    'missingok',
    'notifempty',
    'sharedscripts',
    'delaycompress',
    ],
  $service_restart  = '/sbin/service httpd reload',) {
  include 'sslfile'
  include 'httpscheck'

  # Replace welcome.conf for SSL
  httpd::file { '$sslconf/welcome.conf': source => "puppet:///modules/srechallenge/files/welcome.conf", }
}

# Verify http running and restart
#service { 'httpd':
#  ensure    => running,
#  enable    => true,
#  restart   => $::service_restart,
#  hasstatus => true,
#  require   => Package['httpd'],
#}

# Verify mod_ssl installed
package { 'mod_ssl':
  ensure => installed,
  notify => Service['httpd'],
}

# Verify ssl.conf installed
file { '/etc/httpd/conf.d/ssl.conf':
  ensure  => "present",
  source  => "puppet:///modules/srechallenge/files/ssl.conf",
  require => Package['mod_ssl'],
}

