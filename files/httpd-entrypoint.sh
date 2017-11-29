#!/usr/bin/bash

# prefork / worker / event
MPM=${HTTPD_MPM:=prefork}
echo "LoadModule mpm_${MPM}_module modules/mod_mpm_${MPM}.so"  > /etc/httpd/conf.modules.d/00-mpm.conf


exec /usr/bin/supervisord -c /etc/supervisord.conf
