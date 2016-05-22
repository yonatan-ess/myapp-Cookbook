include_recipe "apache2::mod_jk"
include_recipe "apache2::mod_ssl"

#APACHE

web_app "credorax" do
  template 'credorax.com.conf'
  server_name "Credorax.com"
  server_aliases ["www.credorax.com" ]

end

template '/etc/apache2/sites-enabled/workers.properties' do
  source 'workers.properties'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/apache2/sites-enabled/mod_jk.conf' do
  source 'mod_jk.conf'
  owner 'root'
  group 'root'
  mode '0644'
end



###Tomcat 

apt_package 'openjdk-7-jre'

tomcat_install 'helloworld' do
  version '8.0.32'
end

template '/opt/tomcat_helloworld/conf/server.xml' do
  source 'server.xml'
  owner 'tomcat_helloworld'
  group 'root'
  mode '0644'
end

tomcat_service 'helloworld' do
  action :start
  env_vars [{ 'CATALINA_PID' => '/my/special/path/tomcat.pid' }]
end



##Mysql 
mysql_client 'default' do
  action :create
end

mysql_service 'default' do
  port '3306'
  version '5.5'
  run_user 'mysql'
  initial_root_password 'ubuntu'
  action [:create, :start]
end


bash 'create user' do
  code <<-EOH
   mysql --defaults-file=/etc/mysql-default/my.cnf -u root -pubuntu  -e "GRANT SELECT ON *.* TO credorax@'localhost' IDENTIFIED BY '1qaz@wsx';"
    EOH
end
