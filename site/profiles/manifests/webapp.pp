class profiles::webapp {

 file { 'www-data':
  ensure => 'directory',
  owner  => 'apache',
  group  => 'apache',
  mode   => '774',
  path   => '/var/www'
  }

file { 'requirements.txt':
  ensure => file,
  source => 'puppet:///requirements.txt'
  target => '/tmp/requirements.txt'
  owner  => 'apache',
  group  => 'apache',
  mode   => '774'
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
  requirements => '/tmp/requirements.txt',
  systempkgs   => true,
  distribute   => false,
  venv_dir     => '/var/www/virtualenv',
  owner        => 'apache',
  group        => 'apache',
  cwd          => '/var/www/webapp',
  timeout      => 0,
 }

}
