#
# this is an example what is based on the shipped example. But we are using hiera instead. Because to show you what a can do
#
class profiles::mongodb {
  class { '::mongodb::globals':
    manage_package_repo => true
  } ->
  class { '::mongodb::server':
    smallfiles => true,
    bind_ip    => ['0.0.0.0'],
    replset    => 'rsmain'
  }
  mongodb_replset{'rsmain':
    members => ['mongo1:27017', 'mongo2:27017', 'mongo3:27017' ],
    arbiter => 'mongo3:27017',
  }
}
}
