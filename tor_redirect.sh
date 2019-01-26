#!/bin/bash


#Complete the variables first:

#Add the IP of your public-facing server. This is used to download the list of Tor exits nodes from Tor Project.
SERVERIP="1.2.3.4"

#Add the path to your .htaccess file. This is probably your webroot.
HTACCESS="/path/to/your/.htaccess"

#Add your .onion domain, to which you want your main site to redirect.
ONION="http://dlegal66uj5u2dvcbrev7vv6fjtwnd4moqu7j6jnd42rmbypv3coigyd.onion"

sed -in '/#\ TOR-REDIRECT-BLOCK/,/#\ END-TOR-REDIRECT-BLOCK/d' $HTACCESS
wget -q -O - "https://check.torproject.org/cgi-bin/TorBulkExitList.py?ip=$SERVERIP"| sed '/^\#/d' | sed "s/^/RewriteCond %{REMOTE_ADDR} ^/g; s/\./\\\./g; s/$/\$ \[OR\] /g; 1i# TOR-REDIRECT-BLOCK" >> $HTACCESS
echo "RewriteCond %{REMOTE_ADDR} ^0\.0\.0\.0$" >> $HTACCESS
echo "RewriteRule ^/?(.*) $ONION/\$1 [L,R,NE]" >> $HTACCESS
echo "# END-TOR-REDIRECT-BLOCK" >> $HTACCESS
