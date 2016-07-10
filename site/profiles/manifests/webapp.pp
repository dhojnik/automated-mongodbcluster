class profiles::webapp {

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

 python::virtualenv { '/var/www/webapp' :
  ensure       => present,
  version      => 'system',
  systempkgs   => false,
  distribute   => false,
  venv_dir     => '/var/www/virtualenv',
  owner        => 'apache',
  group        => 'apache',
  timeout      => 0,
 }

python::pip { 'django-bootstrap3' :
  pkgname       => 'django-bootstrap3',
  ensure        => '7.0.1',
  virtualenv    => '/var/www/virtualenv',
  owner         => 'apache',
  group         => 'apache',
  timeout       => 1800,
 }

python::pip { 'click' :
  pkgname       => 'click',
  ensure        => '6.6',
  virtualenv    => '/var/www/virtualenv',
  owner         => 'apache',
  group         => 'apache',
  timeout       => 1800,
 }

python::pip { 'Django' :
  pkgname       => 'Django',
  ensure        => '1.9.7',
  virtualenv    => '/var/www/virtualenv',
  owner         => 'apache',
  group         => 'apache',
  timeout       => 1800,
 }

python::pip { 'Flask' :
  pkgname       => 'Flask',
  ensure        => '0.11.1',
  virtualenv    => '/var/www/virtualenv',
  owner         => 'apache',
  group         => 'apache',
  timeout       => 1800,
 }

python::pip { 'Flask-Script' :
  pkgname       => 'Flask-Script',
  ensure        => '2.0.5',
  virtualenv    => '/var/www/virtualenv',
  owner         => 'apache',
  group         => 'apache',
  timeout       => 1800,
 }

python::pip { 'Flask-WTF' :
  pkgname       => 'Flask-WTF',
  ensure        => '0.12',
  virtualenv    => '/var/www/virtualenv',
  owner         => 'apache',
  group         => 'apache',
  timeout       => 1800,
 }

python::pip { 'flask-mongoengine' :
  pkgname       => 'flask-mongoengine',
  ensure        => '0.7.5',
  virtualenv    => '/var/www/virtualenv',
  owner         => 'apache',
  group         => 'apache',
  timeout       => 1800,
 }

python::pip { 'itsdangerous' :
  pkgname       => 'itsdangerous',
  ensure        => '0.24',
  virtualenv    => '/var/www/virtualenv',
  owner         => 'apache',
  group         => 'apache',
  timeout       => 1800,
 }

python::pip { 'Jinja2' :
  pkgname       => 'Jinja2',
  ensure        => '2.8',
  virtualenv    => '/var/www/virtualenv',
  owner         => 'apache',
  group         => 'apache',
  timeout       => 1800,
 }

python::pip { 'MarkupSafe' :
  pkgname       => 'MarkupSafe',
  ensure        => '0.23',
  virtualenv    => '/var/www/virtualenv',
  owner         => 'apache',
  group         => 'apache',
  timeout       => 1800,
 }

python::pip { 'mongoengine' :
  pkgname       => 'mongoengine',
  ensure        => '0.10.6',
  virtualenv    => '/var/www/virtualenv',
  owner         => 'apache',
  group         => 'apache',
  timeout       => 1800,
 }

python::pip { 'Pillow' :
  pkgname       => 'Pillow',
  ensure        => '3.3.0',
  virtualenv    => '/var/www/virtualenv',
  owner         => 'apache',
  group         => 'apache',
  timeout       => 1800,
 }

python::pip { 'pymongo' :
  pkgname       => 'pymongo',
  ensure        => '3.2.2',
  virtualenv    => '/var/www/virtualenv',
  owner         => 'apache',
  group         => 'apache',
  timeout       => 1800,
 }

python::pip { 'Werkzeug' :
  pkgname       => 'Werkzeug',
  ensure        => '0.11.10',
  virtualenv    => '/var/www/virtualenv',
  owner         => 'apache',
  group         => 'apache',
  timeout       => 1800,
 }

python::pip { 'WTForms' :
  pkgname       => 'WTForms',
  ensure        => '2.1',
  virtualenv    => '/var/www/virtualenv',
  owner         => 'apache',
  group         => 'apache',
  timeout       => 1800,
 }

apache::vhost { 'tumbleblog':
  port                        => '80',
  docroot                     => '/var/www/webapp/tumbleblog/',
  wsgi_application_group      => '%{GLOBAL}',
  wsgi_daemon_process         => 'wsgi',
  wsgi_daemon_process_options => {
    processes    => '2',
    threads      => '15',
    display-name => '%{GROUP}',
  },
  wsgi_import_script          => '/var/www/webapp/tumbleblog/tumbleblog.wsgi',
  wsgi_import_script_options  => {
    process-group     => 'wsgi',
    application-group => '%{GLOBAL}',
  },
  wsgi_process_group          => 'wsgi',
  wsgi_script_aliases         => { '/' => '/var/www/webapp/tumbleblog/tumbleblog.wsgi' },
}

}
