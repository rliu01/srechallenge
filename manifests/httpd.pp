# Apply nhttpd configuration
class httpd::install ($ensure = 'installed',) {
  package { 'httpd': ensure => $ensure }

}

service { 'httpd':
  name      => httpd,
  ensure    => running,
  enable    => true,
  subscribe => File['httpd.conf'],
}

# Place SSL keys

class sslfile {
  file { '/etc/pki/tls/private/localhost.key':
    ensure => present,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/srechallenge/files/localhost.key',
  }

  file { '/etc/pki/tls/private/localhost.csr':
    ensure => present,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/srechallenge/files/localhost.csr',
  }

  file { "/etc/pki/tls/certs":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/srechallenge/files/certs',
  }

  file { "$::documentroot/index.html":
    ensure  => "present",
    source  => "puppet:///modules/srechallenge/files/index.html",
    require => File[$::documentroot],
  }

}