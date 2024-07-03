# This class installs and configures the Apache HTTP server and sets up a virtual host.
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

  # Virtual Host Configuration
  file { '/etc/httpd/conf.d/vhost.conf':
    ensure  => file,
    content => template('apache/vhost.conf.erb'),
    require => Package['httpd'],
  }

  # Create the directory for the virtual host
  file { '/var/www/vhosts/example':
    ensure  => directory,
    require => Package['httpd'],
  }

  # Example content for the virtual host
  file { '/var/www/vhosts/example/index.html':
    ensure  => file,
    content => 'Welcome to the Example Virtual Host!',
    require => File['/var/www/vhosts/example'],
  }
}
