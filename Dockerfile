FROM  fedora:latest

MAINTAINER Francois MICAUX <dok-images@actilis.net> 

LABEL Vendor="Actilis" \
      License=GPLv3 \
      Version=2017.12.20

# Installation Apache + PHP + modules de PHP nécessaires
RUN dnf clean all 
RUN dnf -y repolist \
 && dnf -y install \
        httpd php-fpm git \
        php-{mysqlnd,ldap,imap,curl,gd,mcrypt,mbstring,json,intl,pear} composer \
        supervisor procps \
 && dnf clean all 

# Données à importer (ADD, COPY,...)
COPY files/  /

# Manage permisisons, clean...
RUN rm -f /etc/httpd/conf.d/welcome.conf \
 && chmod  o+x /var /var/www \
 && chown -R apache.apache /var/www/html \
 && chmod -R 750 /var/www/html 

# Ports ?
EXPOSE 80

# Définition de l'entrypoint (ou CMD pendant les tests...)
CMD ["/httpd-entrypoint.sh"]


