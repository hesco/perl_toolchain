
class perl_toolchain::devel_hdb {

    file { '/opt/local/devel_hdb':
        ensure => directory,
    }

    exec { 'install-devel_hdb':
        command => '/usr/bin/cpanm -L /opt/local/devel_hdb http://cpan.metacpan.org/authors/id/B/BR/BRUMMETT/Devel-hdb-0.09.tar.gz',
        creates => '/opt/local/devel_hdb/lib/perl5/Devel/hdb/App/Breakpoint.pm',
        require => File['/usr/bin/cpanm'],
    }

  # augeas { 'set_devel_hdb_paths':
  #   context => '/home/hesco',
  #   changes => [ "ins 'export PERL5LIB=/opt/local/devel_hdb/lib/perl5:$PERL5LIB' after .bash_profile/PERL5LIB",
  #                "ins 'PATH=/opt/local/devel_hdb/bin/:$PATH' after .bashrc/PATH", ],
  # }

}

