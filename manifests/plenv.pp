
class perl_toolchain::plenv {

  file { '/usr/local/bin/plenv':
    ensure => link,
    target => '/opt/local/plenv/libexec/plenv',
  }

  file { '/opt/local/plenv/plugins':
     ensure => directory,
    require => File['/usr/local/bin/plenv'],
  }

  # https://github.com/tokuhirom/plenv
  exec { 'install-plenv':
    command => '/usr/bin/git clone git://github.com/tokuhirom/plenv.git /opt/local/plenv',
    creates => '/opt/local/plenv/plenv.d/rehash/rehash_cpanm.bash',
  }

  # https://github.com/miyagawa/plenv-contrib
  exec { 'install-plenv-contrib':
    command => '/usr/bin/git clone git://github.com/miyagawa/plenv-contrib.git /opt/local/plenv/plugins/plenv-contrib',
    creates => '/opt/local/plenv/plugins/plenv-contrib/bin/plenv-exec-all',
    require => File['/opt/local/plenv/plugins'],
  }

  # https://github.com/tokuhirom/perl-build
  exec { 'install-perl-build-plenv':
    command => '/usr/bin/git clone git://github.com/tokuhirom/Perl-Build.git /opt/local/plenv/plugins/perl-build/',
    creates => '/opt/local/plenv/plugins/perl-build/bin/plenv-install',
    require => File['/opt/local/plenv/plugins'],
  }

}

