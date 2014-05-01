# == Class: perl_toolchain
#
# This module should install a useful tool chain for hosting and
# developing perl code, including: perlenv, pinto, carton, cpanm,
# sqitch, cover, mojo, testing and debugging tools.
#
# === Parameters
#
# None at this time.
#
# === Variables
#
# None at this time.
#
# === Authors
#
# Author Name <hesco@campaignfoundations.com>
#
# === Copyright
#
# Copyright 2013 Hugh Esco
#

class perl_toolchain {
    include perl_toolchain::pinto
    include perl_toolchain::cpanm
    include perl_toolchain::plenv
    # include perl_toolchain::perlbrew
    include perl_toolchain::carton
    include perl_toolchain::mojo
    include perl_toolchain::milla
    include perl_toolchain::app_sqitch
    include perl_toolchain::devel_cover
    include perl_toolchain::devel_hdb
    include perl_toolchain::rex
    include perl_toolchain::test
    include perl_toolchain::app_pmuninstall
    include perl_toolchain::critic

    package { 'perl-doc':
        ensure => latest,
    }

    file { '/usr/bin/cpanm':
        ensure => 'link',
        target => '/opt/local/pinto/sbin/cpanm',
    }

}

