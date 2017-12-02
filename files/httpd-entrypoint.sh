#!/usr/bin/bash

# prefork / worker / event
MPM=${HTTPD_MPM:=event}
echo "LoadModule mpm_${MPM}_module modules/mod_mpm_${MPM}.so"  > /etc/httpd/conf.modules.d/00-mpm.conf

# Apache MPM Tuning defaults 
export MPM_START=${MPM_START:-5}
export MPM_MINSPARE=${MPM_MINSPARE:-5}
export MPM_MAXSPARE=${MPM_MAXSPARE:-10}
export MPM_MAXWORKERS=${MPM_MAXWORKERS:-150}
export MPM_MAXCONNECTIONS=${MPM_MAXCONNECTIONS:-0}
# TODO : Apply MPM conf in 00-mpm.conf to fit variables.


exec /usr/bin/supervisord -c /etc/supervisord.conf
