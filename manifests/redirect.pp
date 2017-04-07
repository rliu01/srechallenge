class redirect {
  include apache

  apache::vhost { 'non-ssl':
    port            => '80',
    docroot         => '/var/www/html',
    redirect_status => 'permanent',
    redirect_dest   => 'https://localhost/'
  }

  apache::vhost { 'ssl':
    port    => '443',
    docroot => '/var/www/html',
    ssl     => true,
  }

}