
class perl_toolchain::perlbrew {

    exec { 'install-perlbrew':
        environment => 'PERLBREW_ROOT=/opt/perl5',
            command => '/usr/bin/curl -kL http://install.perlbrew.pl | /bin/bash',
            creates => '/opt/perl5/bin/perlbrew',
    }

}

