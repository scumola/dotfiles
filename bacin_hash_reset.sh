#!/bin/bash
source ~/.bash_profile

campfire 'prod-radish-memcache RESTARTING (clearing) - STARTED'
echo ""

campfire 'prod-radish-memcache RESTARTING (clearing) - Capturing current bacin hash'
echo ""
~/bacin_hash_read.php

campfire 'prod-radish-memcache RESTARTING (clearing) - Restarting memcache on production servers'
echo ""
#dsh -F 10 -g prod-memcache 'uptime'
dsh -F 10 -g prod-memcache -- 'sudo bash -c \"/etc/init.d/memcached restart\"'

campfire 'prod-radish-memcache RESTARTING (clearing) - Re-populating bacin hash to production memcache'
echo ""
~/bacin_hash_write.php

campfire 'prod-radish-memcache RESTARTING (clearing) - DONE'
echo ""
