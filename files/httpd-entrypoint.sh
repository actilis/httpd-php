#!/bin/bash

# prefork / worker / event
MPM=${HTTPD_MPM:=event}

# On RH/CentOS/Fedora
if which rpm >/dev/null 2>/dev/null ; then
	CONF_DIR=/etc/httpd/conf.d
	echo "LoadModule mpm_${MPM}_module modules/mod_mpm_${MPM}.so"  > /etc/httpd/conf.modules.d/00-mpm.conf
fi

# Alpine
if which apk &>/dev/null ; then
	CONF_DIR=/etc/apache2/conf.d
	sed -i -e '/LoadModule mpm_event/s/^#//' \
	       -e '/LoadModule mpm_prefork/s/^/#/' \
		/etc/apache2/httpd.conf

	# Move files copied by Dockerfile in a RH/CentOS place to the right Alpine place
	mv /etc/php-fpm.d/* /etc/php7/php-fpm.d && rm -rf /etc/php-fpm.d
	mv /etc/httpd/conf.d/* /etc/apache2/conf.d/ && rm -rf /etc/httpd
	# mod_proxy_fcgi uniquement
	sed -i -e '/^LoadModule/s/^/#/' \
               -e '/proxy_module/s/^#//' \
               -e '/proxy_fcgi_module/s/^#//' \
	        /etc/apache2/conf.d/proxy.conf
	install -d -o apache -g apache -m 700 /var/log/httpd
fi

# Apache MPM Tuning defaults 
export MPM_START=${MPM_START:-5}
export MPM_MINSPARE=${MPM_MINSPARE:-5}
export MPM_MAXSPARE=${MPM_MAXSPARE:-10}
export MPM_MAXWORKERS=${MPM_MAXWORKERS:-150}
export MPM_MAXCONNECTIONS=${MPM_MAXCONNECTIONS:-0}

# TODO : Apply MPM conf in 00-mpm.conf to fit variables.

# For PID-file
mkdir -p /run/apache2

# Entrypoint : supervisor for httpd + php-fpm
/usr/bin/supervisord   -c   /etc/supervisord.conf

