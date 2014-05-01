
class perl_toolchain::mojo {

  file { '/opt/local/mojo':
    ensure => directory,
  }

  exec { 'install-mojo':
    command => '/usr/bin/cpanm -L /opt/local/mojo http://cpan.metacpan.org/authors/id/S/SR/SRI/Mojolicious-4.92.tar.gz',
    creates => '/opt/local/mojo/bin/mojo',
    require => File['/usr/bin/cpanm'],
  }

  file { '/usr/bin/mojo':
    ensure => 'link',
    target => '/opt/local/mojo/bin/mojo',
  }

}

