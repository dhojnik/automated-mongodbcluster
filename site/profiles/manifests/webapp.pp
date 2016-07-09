class profiles::webapp {

  package { ['python-django',]:
    ensure  => 'latest',
  }

  package { ['python-pymongo',]:
    ensure  => 'latest',
  }

  package { ['python-mongoengine',]:
    ensure  => 'latest',
  }
}
