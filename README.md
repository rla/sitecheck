Sitecheck
========= 

Script to monitor a number of sites. For each URL it checks
whether the status code is 200. Built using curl.

The script allows to periodically monitor the list of sites. The
result is logged into a log file.

Installation
------------

    adduser sitecheck
    mkdir /opt/sitecheck
    chown sitecheck:sitecheck /opt/sitecheck
    cd /opt/sitecheck
    su sitecheck
    touch sites.txt
    touch sites.log
    
Then copy `sites.sh` to `/opt/sitecheck` and use `chmod +x /opt/sitecheck/sites.sh` to make
it executable.
    
Configuration
-------------

Add crontab entry to run monitoring every 5 minutes:

    */5 * * * * /opt/sitecheck/sites.sh

Add entries to `/opt/sitecheck/sites.txt`. Each line is single URL.

License
-------

The MIT license. See LICENSE file.
