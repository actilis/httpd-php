<VirtualHost *:80>
	ServerAdmin _ADMINNAME_
        ServerName _SITENAME_

	DocumentRoot /var/www/html

	ErrorLog  /var/log/httpd/_SITENAME_/error_log
	CustomLog /var/log/httpd/_SITENAME_/access_log combined

	<Directory /var/www/html>

       		Options FollowSymLinks
	        AllowOverride All

                <IfModule mod_authz_core.c>
                    Require all granted

                    # === VERSION DE PHP =====
                    <FilesMatch "\.php$">
                            SetHandler  "proxy:fcgi://127.0.0.1:9000"
                    </FilesMatch>
                </IfModule>

                DirectoryIndex index.php index.html

	</Directory>

</VirtualHost>

