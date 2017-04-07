class httpscheck { 
    exec { 'httpscheck':
      path => '/usr/bin',
      command => ' curl -s -o /dev/null -I -w "%{http_code}"  --insecure https://localhost',
      returns => '200',
      }
   }