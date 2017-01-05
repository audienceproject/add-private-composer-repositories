#!/bin/bash
# check if config.json already exists, if not create it
if [ ! -f $COMPOSER_HOME/config.json ]; then
    echo "File config.json not found. Creating..."
    touch $COMPOSER_HOME/config.json
    echo '{"repositories":[]}' >> $COMPOSER_HOME/config.json
fi

# check if repositories field exists, if not, add it
if [ x`cat $COMPOSER_HOME/config.json | jq '.repositories'` -eq "null" ]; then
    cat $COMPOSER_HOME/config.json | jq '.repositories=[]' > result.json
    mv -f result.json $COMPOSER_HOME/config.json
fi

# check if repository entry already exists
if [ x`cat $COMPOSER_HOME/config.json | jq --arg type $WERCKER_ADD_PRIVATE_COMPOSER_REPOSITORIES_TYPE --arg url $WERCKER_ADD_PRIVATE_COMPOSER_REPOSITORIES_URL '.repositories | map(contains({"type": $type, "url": $url})) | any'` -eq "true" ]; then
    echo "Private repository entry already present... ignoring."
else
    # add repository entry
    cat $COMPOSER_HOME/config.json | jq --arg type $WERCKER_ADD_PRIVATE_COMPOSER_REPOSITORIES_TYPE --arg url $WERCKER_ADD_PRIVATE_COMPOSER_REPOSITORIES_URL  '.repositories |= .+ [{"type": $type, "url": $url}]' > result.json
    mv -f result.json $COMPOSER_HOME/config.json
fi
