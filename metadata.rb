name             'credorax'
maintainer       'credorax'
maintainer_email 'yonatan.estryk@gmail.com'
license          'All rights reserved'
description      'Installs/Configures credorax app'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "apache2"
depends "tomcat"
depends "compat_resource"
depends "mysql"
depends "database"
