
class perl_toolchain::critic {

  file { '/opt/local/critic':
    ensure => directory,
  }

  exec { 'install-critic':
    timeout => 1200,
    command => '/usr/bin/cpanm -L /opt/local/critic http://search.cpan.org/CPAN/authors/id/T/TH/THALJEF/Perl-Critic-1.121.tar.gz',
    creates => '/opt/local/critic/bin/perlcritic',
    require => [ File['/usr/bin/cpanm'] ],
  }

  exec { 'install-critic-moose':
    timeout => 1200,
    command => '/usr/bin/cpanm -L /opt/local/critic http://search.cpan.org/CPAN/authors/id/E/EL/ELLIOTJS/Perl-Critic-Moose-0.999_002.tar.gz',
    creates => '/opt/local/critic/lib/perl5/Perl/Critic/Moose.pm',
    require => [ File['/usr/bin/cpanm'] ],
  }

}


