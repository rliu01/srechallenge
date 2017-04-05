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
}