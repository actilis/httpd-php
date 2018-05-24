# httpd-php

Now based on Alpine Linux.

Port : tcp/80
Volume : /var/www/html (DocumentRoot)

## Content owners

Warning : 
- for Alpine image : owner of /var/www/html is "apache:apache"
- for Debian image : owner of /var/www/html is "www-data:www-data"

## Alpine Image

Based on Alpine:3.7 with packages installed via apk.

## Debian Image

Debian image includes "composer".

Debian image is based on php:7.2-apache (mod_php as a Handler).

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



