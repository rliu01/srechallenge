#Enable Firewall

class firewall {
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