import "util"
  
  group { "puppet":
    ensure => "present",
  }

# file { "/etc/yum.repos.d":
#    ensure => directory,
#    recurse => true,
#    purge => true
# } 
 
 # yumrepo {'repo-jpackage-dev':
#    name => 'JPackage-generic-dev',
#    baseurl => 'http://mirrors.dotsrc.org/jpackage/6.0/generic/devel/',
#    enabled => '1',
#    gpgcheck => '1',
#    gpgkey => 'http://www.jpackage.org/jpackage.asc'
#  }
  
#  yumrepo {'repo-jpackage-free':
#    name => 'JPackage-generic-free',
#    baseurl => 'http://mirrors.dotsrc.org/jpackage/6.0/generic/free/',
#    enabled => '1',
#    gpgcheck => '1',
#    gpgkey => 'http://www.jpackage.org/jpackage.asc'
#  }

 # Positionner la Time Zone
  file { '/etc/localtime':
    ensure => link,
    target => '/usr/share/zoneinfo/Europe/Paris'
  }
  
 yumrepo {'repo-cache':
    name => 'Local-cache',
    baseurl => 'file:///vagrant_projet/yumRepoCache/',
    enabled => '1',
    gpgcheck => '0'
#	 require => File["/etc/yum.repos.d"]
  }
  
  # SSH est provisionné par défaut par Vagrant mais ça ne coute rien de vérifier
#  package { "openssh-server":
#    before => Notify['Dealing with : SSH server'],
#	ensure => installed,
#  }
#
#  service { "ssh":
#    ensure => running,
#    enable => true,
#    require => Package["openssh-server"],
#    after => Notify['SSH server up and running'],
#  }

  package {"java-1.6.0-openjdk-devel":
    ensure => installed,
    require => Yumrepo["repo-cache"]
  }

  package { "git":
	ensure => installed,
    require => Yumrepo["repo-cache"]
  }
  
  package { "rpm-build":
	ensure => installed,
    require => Yumrepo["repo-cache"]
  }

  package { "redhat-lsb-core":
	ensure => installed,
    require => Yumrepo["repo-cache"]
  }
  
  package { "createrepo":
	ensure => installed,
    require => Yumrepo["repo-cache"]
  }

  package { "ksh":
	ensure => installed,
    require => Yumrepo["repo-cache"]
  }

#  package { 'maven2':
#	require => [ File['repo-jpackage-dev'], File['repo-jpackage-free'] ],
#  }
  
  file { '/etc/motd':
    content => "Welcome to your Vagrant-built virtual machine ${::hostname}!\n  Managed by Puppet.\nA ${::operatingsystem} island in the sea of ${::domain}.\n"
  }
  
  host { 'sgbd':
    ip => '192.168.0.73',
    host_aliases => ['sgbd'],
  }
  
  
# utilisateur pour l'agent Jenkins

# See http://reductivelabs.com/trac/puppet/wiki/TypeReference#id229 
# password fait à l'aide de 'openssl passwd -1' (dans la vm)
user { "jenkinsagent": 
   groups => 'adm', 
   comment => 'This user was created by Puppet', 
   ensure => 'present', 
   managehome => 'true',
   shell   => "/bin/bash",
   password => '$1$MIv5LSV7$kE6MegD/euf4DG2dbCl9L1',
   #home => '/opt/jenkinsAgent',
   #require => file["/opt/jenkinsAgent"]
} 

# ssh_authorized_key{ "jenkinsagent_key":
#		ensure  => present,
#		key     => "jenkinsagent",
#		type    => $type,
#		user    => "jenkinsagent",
#		require => file["/home/jenkinsagent/.ssh/authorized_keys"]
#}


# see http://reductivelabs.com/trac/puppet/wiki/TypeReference#file 
# Espace de travail de jenkins
file { "/opt/jenkinsAgent": 
    ensure => 'directory', 
    require => User['jenkinsagent'], 
    owner => 'jenkinsagent', 
    mode => '744', 
} 

# Répertoire servant de repo YUM de snapshot
file { "/opt/rmp_snapshot": 
    ensure => 'directory', 
    require => User['jenkinsagent'], 
    owner => 'jenkinsagent', 
    mode => '744', 
} 

exec { 'createRepoSnapshot':
         command => "/usr/bin/createrepo -d /opt/rmp_snapshot",
         cwd => '/opt/rmp_snapshot',
         #creates => "${cwd}/${name}",
         require => [ Package['createrepo'], File["/opt/rmp_snapshot"] ],
		 user => 'jenkinsagent'
     }

  yumrepo {'DEV_SNAPSHOT':
    name => 'DEV_SNAPSHOT',
    baseurl => 'file:///opt/rmp_snapshot/',
    enabled => '1',
    gpgcheck => '0',
	metadata_expire => 20,
	require => Exec['createRepoSnapshot']
  }