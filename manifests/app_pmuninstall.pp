
class perl_toolchain::app_pmuninstall {

  perl_toolchain::cpanm::install { 'install-app-pmuninstall':
     using => '/usr/bin/cpanm',
      perl => '/usr/bin/perl',
     local => '/opt/local',
    module => 'App::pmuninstall',
    source => 'http://cpan.metacpan.org/authors/id/X/XA/XAICRON/App-pmuninstall-0.30.tar.gz',
  }

}

