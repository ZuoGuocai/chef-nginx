name             'nginx'
maintainer       'Jean-Francois Theroux'
maintainer_email 'me@failshell.io'
license          'Apache 2.0'
description      'Installs/Configures nginx'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.6.0'

depends          'yum'
depends          'yum-epel'
