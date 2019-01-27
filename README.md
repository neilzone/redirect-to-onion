# redirect-to-onion
Redirects a clearweb domain to a .onion / hidden service

This has been tested with Apache 2.4. You can probably use a similar principle with nginx.

It puts the RewriteConditions into your site's .htaccess file. You could also put it into your Apache config directly, I expect, but I have not tested this.

Save the script into your chosen directory (outside your webroot), and then set a cronjob to run it. For example:

<code>
crontab -e

10 * * * * /bin/bash /path/to/your/script/tor_redirect.sh >/dev/null 2>&1
</code>

(This will download a new list of Tor exit nodes every hour, every day, at 10 minutes past the hour.)
