# Magento Information Gathering


This script is designed to be run on Linux devices with Magento stores running on them.
It can be used to gather all the information you need to a Magento store, quickly and efficiently. 
This then allows you to troubleshoot any potential issue with the store quicker - no more searching for details

bash <(curl -s https://raw.githubusercontent.com/luke7858/magento_info_gathering/master/information.sh)

----------------------------------------------
Script will pull in the following information. Below is an example output:

EDITION:  Enterprise/Community

VERSION:  x.x.x.x


Database
------------------
Host              :  localhost

Username          :  magentodbuser

Password          :  magentodbpass

Database          :  magento

Sessions
------------------
session_save      :  memcache

session_save_path :  tcp://127.0.0.1:11211?persistent=0&amp;weight=2&amp;timeout=10&amp;retry_interval=10

Cache
------------------
Backend           :  Cm_Cache_Backend_Redis

Server            :  /tmp/redis-cache.sock

Port              :  6379

Database          :  1

Password          : 

Full Page Cache
------------------
Backend           :  Cm_Cache_Backend_Redis

Server            :  /tmp/redis-fullpage.sock

Port              :  0

Database          :  2

Password          : 
