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
  requirements => '/var/www/webapp/requirements.txt',
  systempkgs   => true,
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

}
