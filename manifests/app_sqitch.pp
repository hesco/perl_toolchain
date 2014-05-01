
class perl_toolchain::app_sqitch {

  file { '/opt/local/sqitch':
    ensure => directory,
  }

  exec { 'install-sqitch':
    timeout => 600,
    command => '/usr/bin/cpanm -L /opt/local/sqitch http://cpan.metacpan.org/authors/id/D/DW/DWHEELER/App-Sqitch-0.982.tar.gz',
    creates => '/opt/local/sqitch/bin/sqitch',
    require => File['/usr/bin/cpanm'],
  }

  exec { 'install-sqitch-dbd-pg':
    command => '/usr/bin/cpanm --force -L /opt/local/sqitch http://cpan.metacpan.org/authors/id/T/TU/TURNSTEP/DBD-Pg-2.19.3.tar.gz',
    creates =>'/opt/local/sqitch/lib/perl5/i486-linux-gnu-thread-multi-64int/DBD/Pg.pm',
    require => Exec['install-sqitch'],
  }

  exec { 'install-sqitch-dbd-sqlite':
    command => '/usr/bin/cpanm -L /opt/local/sqitch http://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/DBD-SQLite-1.40.tar.gz',
    creates =>'/opt/local/sqitch/lib/perl5/i486-linux-gnu-thread-multi-64int/DBD/SQLite/Cookbook.pod',
    require => Exec['install-sqitch'],
  }

  file { '/usr/bin/sqitch':
     ensure => 'link',
     target => '/opt/local/sqitch/bin/sqitch',
    require => Exec['install-sqitch'],
  }

}

