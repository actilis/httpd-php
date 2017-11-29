FROM  actilis/centos7-base

MAINTAINER Francois MICAUX <dok-images@actilis.net> 

LABEL Vendor="Actilis" \
      License=GPLv3 \
      Version=2017.11

# Installation Apache + PHP + modules de PHP nécessaires
RUN yum clean all && yum -y repolist \
 && yum -y install httpd24u php70u-fpm git \
                   httpd24u-mod_ssl \
                   php70u-{mysqlnd,ldap,imap,curl,gd,mcrypt,mbstring,json,intl,pear} \
		   supervisor \
 && yum clean all && rm -rf /var/cache/yum

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


