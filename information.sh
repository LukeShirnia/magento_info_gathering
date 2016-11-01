#!/bin/bash
function xml_info {

format='--------------------------------------------------------------------------------------------'

echo ''
echo $config
echo ''
echo 'Database'
echo '------------------'
echo 'Host              : ' $(xmllint --nocdata --xpath '/config/global/resources/default_setup/connection/host/text()' $config 2>/dev/null)
echo 'Username          : ' $(xmllint --nocdata --xpath '/config/global/resources/default_setup/connection/username/text()' $config 2>/dev/null)
echo 'Password          : ' $(xmllint --nocdata --xpath '/config/global/resources/default_setup/connection/password/text()' $config 2>/dev/null)
echo 'Database          : ' $(xmllint --nocdata --xpath '/config/global/resources/default_setup/connection/dbname/text()' $config 2>/dev/null)
echo ''
echo 'Sessions'
echo '------------------'

if [[ $(xmllint --nocdata --xpath '/config/global/session_save/text()' $config 2>/dev/null ) == "db" ]]; then
        echo 'Redis_session     : ' $(xmllint --nocdata --xpath '/config/global/redis_session/host' $config 2>/dev/null | sed 's/<host>//g' | sed 's/<[/]host>//g')
        echo 'Redis_db          : ' $(xmllint --nocdata --xpath '/config/global/redis_session/db' $config 2>/dev/null | sed 's/<db>//g' | sed 's/<[/]db>//g')
        echo 'Redis_port        : ' $(xmllint --nocdata --xpath '/config/global/redis_session/port' $config 2>/dev/null | sed 's/<port>//g' | sed 's/<[/]port>//g')
        echo 'Redis_password    : ' $(xmllint --nocdata --xpath '/config/global/redis_session/password' $config 2>/dev/null | sed 's/<password>//g' | sed 's/<[/]password>//g' )
        echo '' 
else
        echo 'session_save      : ' $(xmllint --nocdata --xpath '/config/global/session_save/text()' $config 2>/dev/null)
fi

echo ''
echo 'Cache'
echo '------------------'
echo 'Backend           : ' $(xmllint --nocdata --xpath '/config/global/cache/backend/text()' $config 2>/dev/null)
echo 'Server            : ' $(xmllint --nocdata --xpath '/config/global/cache/backend_options/server/text()' $config 2>/dev/null)
echo 'Port              : ' $(xmllint --nocdata --xpath '/config/global/cache/backend_options/port/text()' $config 2>/dev/null)
echo 'Database          : ' $(xmllint --nocdata --xpath '/config/global/cache/backend_options/database/text()' $config 2>/dev/null)
echo 'Password          : ' $(xmllint --nocdata --xpath '/config/global/cache/backend_options/password/text()' $config 2>/dev/null)
echo ''
echo 'Full Page Cache'
echo '------------------'
echo 'Backend           : ' $(xmllint --nocdata --xpath '/config/global/full_page_cache/backend/text()' $config 2>/dev/null)
echo 'Server            : ' $(xmllint --nocdata --xpath '/config/global/full_page_cache/backend_options/server/text()' $config 2>/dev/null)
echo 'Port              : ' $(xmllint --nocdata --xpath '/config/global/full_page_cache/backend_options/port/text()' $config 2>/dev/null)
echo 'Database          : ' $(xmllint --nocdata --xpath '/config/global/full_page_cache/backend_options/database/text()' $config 2>/dev/null)
echo 'Password          : ' $(xmllint --nocdata --xpath '/config/global/full_page_cache/backend_options/password/text()' $config 2>/dev/null)
echo ''
echo 'Front Name'
echo '------------------'
echo 'FrontName         : ' $(xmllint --nocdata --xpath '/config/admin/routers/adminhtml/args/frontName/text()' $config 2>/dev/null)
echo $format
}

function config {
        echo $format
        for config in $(locate app/etc/local.xml | grep xml$); do xml_info; done
}

updatedb
config
