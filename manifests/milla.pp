
class perl_toolchain::milla {

  file { '/opt/local/milla':
    ensure => directory,
  }

  exec { 'install-milla':
    timeout => 1200,
    command => '/usr/bin/cpanm -L /opt/local/milla http://cpan.metacpan.org/authors/id/M/MI/MIYAGAWA/Dist-Milla-v1.0.4.tar.gz',
    creates => '/opt/local/milla/bin/milla',
    require => File['/usr/bin/cpanm'],
  }

  file { '/usr/bin/milla':
    ensure => 'link',
    target => '/opt/local/milla/bin/milla',
  }

}

