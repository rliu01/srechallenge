
class httpd (
 
  # timeout is a reserved puppet variable
  $timeout_seconds        = '60',
  $keepalive              = 'Off',
  $maxkeepaliverequests   = '100',
  $keepalivetimeout       = '15',
  $startservers           = '4',
  $minspareservers        = '2',
  $maxspareservers        = '8',
  $serverlimit            = '256',
  $maxclients             = '256',
  $maxrequestsperchild    = '4000',
  $minsparethreads        = '25',
  $maxsparethreads        = '75',
  $threadsperchild        = '32',
  $listen                 = [ '80' ],
  $namevirtualhost        = [],
  $extendedstatus         = 'Off',
  $user                   = 'root',
  $group                  = 'root',
  $serveradmin            = 'root@localhost',
  $servername             = undef,
  $usecanonicalname       = 'Off',
  $documentroot           = '/var/www/html',
  $serversignature        = 'On',
  $sslconf = '/etc/httpd/conf.d',
  $logrotate_files        = '/var/log/httpd/*log',
  $logrotate_freq         = false,
  $logrotate_opts         = [
    'missingok',
    'notifempty',
    'sharedscripts',
    'delaycompress',
  ],
  $service_restart        = '/sbin/service httpd reload',
) 
 {

  include 'httpd::install'

  # Our own pre-configured file (disable nearly everything)
 
  # Change the original welcome condition, since our default has the index
  # return 404 instead of 403.
  httpd::file { '$sslconf/welcome.conf':
      source => "puppet:///modules/srechallenge/files/welcome.conf",
    }
  } 

 
  # Main service
  service { 'httpd':
    ensure    => running,
    enable    => true,
    restart   => $::service_restart,
    hasstatus => true,
    require   => Package['httpd'],
  }
  
    package { '$sslconf/mod_ssl':
      ensure => installed,
      notify => Service['httpd'],
    }
 
    httpd::file { '$sslconf/ssl.conf':
      ensure => "present",
      source  => "puppet:///modules/srechallenge/files/ssl.conf",
      require => Package['mod_ssl'],
    }
  



