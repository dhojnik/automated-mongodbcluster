class profiles::webapp {

python::virtualenv { '/var/www/webapp' :
  ensure       => present,
  version      => 'system',
  requirements => '/root/requirements.txt',
  systempkgs   => true,
  distribute   => false,
  venv_dir     => '/var/www/virtualenvs',
  owner        => 'apache',
  group        => 'apache',
  cwd          => '/var/www/webapp',
  timeout      => 0,
 }

}
