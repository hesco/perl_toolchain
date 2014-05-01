
# Our cpanm is actually a symlink to the pinto
# installation.  See: perl_toolchain::pinto

# Thanks to alnewkirk on #perl-help channel
# http://pastie.org/8443394
# usage:
#   profile::utility::cpan { 'Dancer':
#        using => 'cpanm',
#       module => 'Dancer'
#   }

class perl_toolchain::cpanm::install {

  # cpan dependency installation
  define perl_toolchain::cpanm::install (
    $using  = '/usr/bin/cpanm',
    $perl   = '/usr/bin/perl',
    $local  = '/opt/local',
    $source = undef,
    $module = undef
  )
  {
    exec { "cpanm:${module}":
      environment => "PERL5LIB=${local}/lib/perl5:$PERL5LIB",
          command => "${using} -L ${local} ${module}",
          onlyif  => "${perl} -e \"!eval q{require ${module}}?exit(0):exit(1)\""
    }
  }

}

