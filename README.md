# httpd-php

Now based on Alpine Linux or Debian.

Port : tcp/80
Volume : /var/www/html (DocumentRoot)

## Content owners

Warning : 
- for Alpine image : /var/www/html is owned by "apache:apache"
- for Debian image : /var/www/html is owned by "www-data:www-data"

## Alpine Image

Based on Alpine:3.7 with packages installed via apk. 

This image is as light as possible.


## Debian Image

Debian image includes "composer".

Debian image is based on php:7.2-apache (mod_php as a Handler).

This image is to be used for some apps.

PHP Extensions :
```
Core
ctype
curl
date
dom
fileinfo
filter
ftp
gd
hash
iconv
imap
intl
json
ldap
libxml
mbstring
mysqlnd
openssl
pcre
PDO
pdo_mysql
pdo_sqlite
Phar
posix
readline
Reflection
session
SimpleXML
sodium
SPL
sqlite3
standard
tokenizer
xml
xmlreader
xmlwriter
zip
zlib

```



