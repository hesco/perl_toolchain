
class perl_toolchain::carton {

    file { '/opt/local/carton':
        ensure => directory,
    }

    exec { 'install-carton':
        command => '/usr/bin/cpanm -L /opt/local/carton http://search.cpan.org/CPAN/authors/id/M/MI/MIYAGAWA/Carton-v1.0.9.tar.gz',
        creates => '/opt/local/carton/bin/carton',
        require => File['/usr/bin/cpanm'],
    }

    file { '/usr/bin/carton':
        ensure => 'link',
        target => '/opt/local/carton/bin/carton',
    }

}

