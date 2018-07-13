#!/bin/bash

sed -i -e '/LoadModule mpm_event/s/^#//' -e '/LoadModule mpm_prefork/s/^/#/' -e '/LoadModule slotmem_shm_module/s/^#//' /etc/apache2/httpd.conf

sed -i -e '/^LoadModule/s/^/#/' -e '/proxy_module/s/^#//' -e '/proxy_fcgi_module/s/^#//' /etc/apache2/conf.d/proxy.conf

echo -e "\nProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://127.0.0.1:9000/var/www/localhost/htdocs/\$1\nDirectoryIndex index.php"  > /etc/apache2/conf.d/php.conf

# Move DocumentRoot to /var/www/html
sed -i -e 's,/var/www/localhost/htdocs,/var/www/html,' /etc/apache2/httpd.conf /etc/apache2/conf.d/php.conf

mkdir -p /run/php-fpm /run/apache2
cat <<DONE > /etc/supervisord.conf
[supervisord]
user=root
nodaemon=true              ; (start in foreground if true;default false)
logfile=/var/log/supervisord.log  ; (main log file;default $CWD/supervisord.log)
logfile_maxbytes=50MB       ; (max main logfile bytes b4 rotation;default 50MB)
logfile_backups=10          ; (num of main logfile rotation backups;default 10)
loglevel=info               ; (log level;default info; others: debug,warn,trace)
pidfile=/var/run/supervisord.pid ; (supervisord pidfile;default supervisord.pid)
;minfds=1024                 ; (min. avail startup file descriptors;default 1024)
;minprocs=200                ; (min. avail process descriptors;default 200)
;umask=022                  ; (process file creation umask;default 022)
;user=chrism                 ; (default is current user, required if root)
;identifier=supervisor       ; (supervisord identifier, default is 'supervisor')
;directory=/tmp              ; (default is not to cd during start)
;nocleanup=true              ; (don't clean up tempfiles at start;default false)
;childlogdir=/tmp            ; ('AUTO' child log dir, default $TEMP)
;environment=KEY=value       ; (key value pairs to add to environment)
;strip_ansi=false            ; (strip ansi escape codes in logs; def. false)

[program:httpd]
command=/usr/sbin/httpd -DFOREGROUND

[program:phpfpm]
command=/usr/sbin/php-fpm7 -F
DONE

exec "$@"

