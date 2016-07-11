class profiles::webapp {

 package { ['git',]:
  ensure  => 'latest',
  }

 package { ['lynx',]:
  ensure  => 'latest',
  }

 file { 'www-data':
  ensure => 'directory',
  owner  => 'apache',
  group  => 'apache',
  mode   => '774',
  path   => '/var/www'
  }

vcsrepo { '/var/www/webapp':
  ensure   => present,
  provider => git,
  source   => 'https://github.com/dhojnik/tumbleblog.git',
}

 file { 'www-webapp':
  ensure => 'directory',
  owner  => 'apache',
  group  => 'apache',
  mode   => '774',
  path   => '/var/www/webapp'
  }

class { 'apache':
  default_vhost => false,
}

apache::vhost { 'tumbleblog.webterrorist.net':
  port                        => '80',
  docroot                     => '/var/www/webapp/',
  wsgi_application_group      => '%{GLOBAL}',
  wsgi_daemon_process         => 'wsgi',
  wsgi_daemon_process_options => {
    processes    => '2',
    threads      => '15',
    display-name => '%{GROUP}',
  },
  wsgi_import_script          => '/var/www/webapp/tumbleblog.wsgi',
  wsgi_import_script_options  => {
    process-group     => 'wsgi',
    application-group => '%{GLOBAL}',
  },
  wsgi_process_group          => 'wsgi',
  wsgi_script_aliases         => { '/' => '/var/www/webapp/tumbleblog.wsgi' },
}

}
