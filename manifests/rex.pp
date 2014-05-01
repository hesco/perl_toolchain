
class perl_toolchain::rex {

  package { 'libssh2-1-dev':
    ensure => latest,
  }

  file { '/opt/local/rex':
    ensure => directory,
  }

  exec { 'install-rex':
    timeout => 1200,
    command => '/usr/bin/cpanm -L /opt/local/rex http://cpan.metacpan.org/authors/id/J/JF/JFRIED/Rex-0.43.7.tar.gz',
    creates => '/opt/local/rex/bin/rex',
    require => [ File['/usr/bin/cpanm'],
                 Package['libssh2-1-dev'] ],
  }

}


