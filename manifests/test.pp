
class perl_toolchain::test {

  file { '/opt/local/test':
    ensure => directory,
  }

  exec { 'install-test-perl-critic':
    timeout => 1200,
    command => '/usr/bin/cpanm -L /opt/local/test http://search.cpan.org/CPAN/authors/id/T/TH/THALJEF/Test-Perl-Critic-1.02.tar.gz',
    creates => '/opt/local/test/lib/perl5/Test/Perl/Critic/Policy.pm',
    require => File['/usr/bin/cpanm'],
  }

  exec { 'install-test-framework':
    command => '/usr/bin/cpanm -L /opt/local/test http://cpan.metacpan.org/authors/id/O/OV/OVID/Test-Most-0.31.tar.gz',
    creates => '/opt/local/test/lib/perl5/Test/Most/Exception.pm',
    require => File['/usr/bin/cpanm'],
  }

  exec { 'install-test-perl-critic-progressive':
    timeout => 1200,
    command => '/usr/bin/cpanm -L /opt/local/critic http://search.cpan.org/CPAN/authors/id/T/TH/THALJEF/Test-Perl-Critic-Progressive-0.03.tar.gz',
    creates => '/opt/local/test/lib/perl5/Test/Perl/Critic/Progressive.pm',
    require => [ File['/usr/bin/cpanm'] ],
  }

#  exec { 'install-perl-debug-tools':
#    command => '/usr/bin/cpanm -L /opt/local/test http://cpan.metacpan.org/authors/id/M/MI/MITHALDU/DB-Skip-1.132980.tar.gz',
#    creates => '/opt/local/test/lib/perl5/DB/Skip.pm',
#    require => File['/usr/bin/cpanm'],
#  }

  perl_toolchain::cpanm::install { 'install-perl-debug-tools':
     using => '/usr/bin/cpanm',
      perl => '/usr/bin/perl',
     local => '/opt/local',
    module => 'DB::Skip',
    source => 'http://cpan.metacpan.org/authors/id/M/MI/MITHALDU/DB-Skip-1.132980.tar.gz',
  }

}

