# Apply nhttpd and firewall configuration
class sslfile {
  include apache
  include firewall
  # Verify ssl.conf installed
  file { '/etc/httpd/conf.d/ssl.conf':
    ensure  => "present",
    source  => "puppet:///modules/srechallenge/files/ssl.conf",
    require => Package['mod_ssl'],
  }

  file { '/etc/pki/tls/private/localhost.key':
    ensure => present,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/srechallenge/files/ssl/localhost.key',
  }

  file { '/etc/pki/tls/private/localhost.csr':
    ensure => present,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/srechallenge/files/ssl/localhost.csr',
  }

  file { '/etc/pki/tls/certs':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/srechallenge/files/ssl/localhost.crt',
  }

  file { '/var/www/html/index.html':
    ensure  => "present",
    source  => "puppet:///modules/srechallenge/files/index.html",
    require => File[$::documentroot],
  }
}
# Verify mod_ssl installed
package { 'mod_ssl':
  ensure => installed,
  provider => 'yum',
  install_options => ['install', '-y'],
  notify => ['httpd'],
  }

#  # Replace welcome.conf for SSL
#  file { '//welcome.conf":
#    ensure  => "present",
#    source => "puppet:///modules/srechallenge/files/welcome.conf", }
#}
#
class newfirewall {
  firewall { '100 allow https access':
    port   => '443',
    proto  => tcp,
    action => accept,
  }

  firewall { '100 allow http access':
    port   => '80',
    proto  => tcp,
    action => accept,
  }

  firewall { '100 allow ssh access':
    port   => '22',
    proto  => tcp,
    action => accept,
  }

}