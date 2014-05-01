
# Puppet pinto manifest

class perl_toolchain::pinto {
  # require bash
  require build_toolchain
  require file_tree
  require user

  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  file { '/etc/pinto':
        ensure => 'directory',
         owner => 'pinto',
         group => 'pinto',
          mode => '0754',
  }

  file { '/opt/local/pinto':
     ensure => 'directory',
      owner => 'pinto',
      group => 'pinto',
       mode => '0755',
    require => [ File['/opt/local'] ],
  }

  file { '/opt/local/pinto/.ssh':
        ensure => 'directory',
         owner => 'pinto',
         group => 'pinto',
          mode => '0700',
       require => [ File['/opt/local/pinto'] ],
  }

  file { '/root/lib/sh/pinto_install.sh':
       ensure  => present,
          mode => '0755',
         owner => 'root',
         group => 'root',
       replace => true,
        source => 'puppet:///modules/pinto/root/lib/sh/pinto_install.sh',
       require => [ File['/opt/local/pinto'] ],
  }

  exec { 'install-pinto':
        timeout => 1200,
        command => '/root/lib/sh/pinto_install.sh',
        creates => '/opt/local/pinto/bin/pinto',
  }

  exec { 'create-pinto-version-file':
    environment => 'PINTO_HOME=/opt/local/pinto',
        command => '/opt/local/pinto/bin/pinto --version > /opt/local/pinto/version',
        require => [ Exec['install-pinto'] ],
        creates => '/opt/local/pinto/version',
  }

  if $::fqdn == 'git.yourmessagedelivered.com' {

    file { '/etc/pinto/htpasswd':
            ensure => 'directory',
             owner => 'root',
             group => 'pinto',
              mode => '0640',
            source => 'puppet:///modules/pinto/etc/pinto/htpasswd.starter',
           require => [ File['/etc/pinto'] ],
    }

    file { '/var/pinto':
            ensure => 'directory',
              mode => '0744',
             owner => 'pinto',
             group => 'pinto',
    }

    file { '/etc/init.d/pintod':
            ensure => present,
              mode => '0754',
             owner => 'root',
             group => 'pinto',
           replace => true,
            source => 'puppet:///modules/pinto/etc/init.d/pintod.debian',
           require => [ File['/opt/local/pinto'], File['/var/pinto'] ],
    }

    exec { 'pinto-init':
               user => 'pinto',
            command => '/opt/local/pinto/bin/pinto -r /var/pinto init',
            require => [ File['/var/pinto'], Exec['install-pinto'] ],
            creates => '/var/pinto/stacks/master/authors/01mailrc.txt.gz',
    }

    file { '/var/run/pinto':
              ensure => 'directory',
               owner => 'pinto',
               group => 'pinto',
                mode => '0754',
    }

    exec { '/etc/init.d/pintod':
               user => 'pinto',
            creates => '/var/run/puppet/pintod.starman.pid',
            command => '/etc/init.d/pintod start',
            require => [ Exec['pinto-init'], File['/etc/init.d/pintod'] ],
    }

  }

}

