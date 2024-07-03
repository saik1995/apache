# This class installs and configures the Apache HTTP server.
class apache {
  package { 'httpd':
    ensure => installed,
  }

  service { 'httpd':
    ensure  => running,
    enable  => true,
    require => Package['httpd'],
  }

  file { '/var/www/html/index.html':
    ensure  => file,
    content => 'Hello, Puppet!',
  }
}
