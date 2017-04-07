# Define the parameters



class { 'apache':
  default_vhost => true,
}
apache::listen { '80': }
apache::listen { '443': }
 apache::vhost { 'non-ssl':
  port       => '80',
  ip_based   => true,
  docroot    => '/var/www/html',
}

apache::vhost { 'ssl':
  port       => '443',
  ip_based   => true,
  docroot    => '/var/www/html',
  ssl        => true,
}


