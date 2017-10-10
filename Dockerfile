FROM  actilis/centos7-base

MAINTAINER Francois MICAUX <dok-images@actilis.net> 

LABEL Vendor="Actilis" \
      License=GPLv2 \
      Version=2017.10

# Installation Apache + PHP + modules de PHP nécessaires
RUN yum -y install httpd24u php70u git \
                   httpd24u-mod_ssl \
                   php70u-{mysqlnd,ldap,imap,curl,gd,mcrypt,mbstring,json,intl,pear} \
 && yum -y install composer \
 && yum clean all && rm -rf /var/cache/yum


# IP Addr en accueil par défaut 
RUN rm -f /var/www/html/index.html && echo "<?php  printf("My IP is %s\n", $_SERVER["SERVER_ADDR"]); ?> " > /var/www/html/index.php

# Données à importer (ADD, COPY,...)
COPY files/  /

# Ports ?
EXPOSE 80

# Définition de l'entrypoint (ou CMD pendant les tests...)
CMD ["/entrypoint.sh"]


