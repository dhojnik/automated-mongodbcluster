class profiles::mongodb {
  class { '::mongodb::globals':
    manage_package_repo => true
  } ->
  class { '::mongodb::server':
    smallfiles => true,
    bind_ip    => ['0.0.0.0'],
    replset    => 'rsmain'
  }
}
