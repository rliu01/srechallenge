
class httpd::install ($ensure = 'installed',) {
  package { 'httpd': ensure => $ensure }

}

service { 'httpd':
  name      => httpd,
  ensure    => running,
  enable    => true,
  subscribe => File['httpd.conf'],
}

class sslfile {
  file { '/etc/pki/tls/private/localhost.key':
    ensure => present,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/srechallenge/files/localhost.key',
  }

  file { "$::documentroot/index.html":
    ensure  => "present",
    source  => "puppet:///modules/srechallenge/files/index.html",
    require => File[$::documentroot],
  }

}