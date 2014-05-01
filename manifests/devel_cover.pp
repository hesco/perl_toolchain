
class perl_toolchain::devel_cover {

    file { '/opt/local/devel_cover':
        ensure => directory,
    }

    exec { 'install-devel_cover':
        command => '/usr/bin/cpanm -L /opt/local/devel_cover http://search.cpan.org/CPAN/authors/id/P/PJ/PJCJ/Devel-Cover-1.08.tar.gz',
        creates => '/opt/local/devel_cover/lib/perl5/i486-linux-gnu-thread-multi-64int/Devel/Cover/Report/Html.pm',
        require => File['/usr/bin/cpanm'],
    }

    file { '/usr/bin/cover':
        ensure => 'link',
        target => '/opt/local/devel_cover/bin/cover',
    }

    file { '/usr/bin/cpancover':
        ensure => 'link',
        target => '/opt/local/devel_cover/bin/cpancover',
    }

    file { '/usr/bin/gcov2perl':
        ensure => 'link',
        target => '/opt/local/devel_cover/bin/gcov2perl',
    }

}

