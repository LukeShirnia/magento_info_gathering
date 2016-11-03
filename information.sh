#!/bin/bash
format='--------------------------------------------------------------------------------------------'
function xml_info {
#####Print Edition And Version
echo $config
echo ""
echo "EDITION: " `php -r "require '"$config_mage"'; echo Mage::getEdition(); "`
echo "VERSION: " `php -r "require '"$config_mage"'; echo Mage::getVersion(); "`

#####Print DB/Session/Caching Details
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

echo 'session_save      : ' $(xmllint --nocdata --xpath '/config/global/session_save/text()' $config 2>/dev/null)

if [[ ! $(xmllint --nocdata --xpath '/config/global/session_save_path/text()' $config 2>/dev/nul ) == "" ]]; then
        echo 'session_save_path : ' $(xmllint --nocdata --xpath '/config/global/session_save_path/text()' $config 2>/dev/null)
else
echo "cry"
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
function whichsite {
number=0
echo $format
echo "A - Show config for all sites"

########XML FILE
for config in $(locate app/etc/local.xml | grep xml$); do
        sitearray+=($config);  done
########MAGE FILE
for mage_config in $( locate app/etc/local.xml | grep xml$ | sed 's/etc[/]local.xml/Mage.php/g'); do
        mage_array+=($mage_config); done
########Print sites
for i in "${sitearray[@]}"
do
        echo "$number" - "$i"
        number=$[number+1]
done
echo $format
        read -p "Which option would you like to choose? " answer
echo $format
}
function config {
echo $format
        case $answer in
        "A" )
                for config in $(locate app/etc/local.xml | grep xml$); do xml_info; done
        ;;

        [0-9])
                config_mage=${mage_array[$answer]};
                config=${sitearray[$answer]}; xml_info
        ;;
        *)
                echo "Invalid response"
        ;;
        esac
}


updatedb
whichsite
config
