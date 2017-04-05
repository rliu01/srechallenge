define httpd::file (
  $ensure  = undef,
  $confd   = '/etc/httpd/conf.d',
  $owner   = 'root',
  $group   = 'root',
  $mode    = '0644',
  $source  = undef,
  $content = undef,
) {
  file { "${confd}/${title}":
    ensure  => $ensure,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    source  => $source,
    content => $content,
    notify  => Service['httpd'],
    # For the default parent directory
    require => Package['httpd'],
  }
}
file {'httpd.conf':
  ensure => present,
  path =>'/etc/httpd/conf/httpd.conf'
  
}