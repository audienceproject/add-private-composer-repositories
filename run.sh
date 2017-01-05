#!/bin/bash
# check if config.json already exists, if not create it
if [ ! -f $COMPOSER_HOME/config.json ]; then
    echo "File config.json not found. Creating..."
    touch $COMPOSER_HOME/config.json
    echo '{"repositories":[]}' >> $COMPOSER_HOME/config.json
fi

# check if repositories field exists, if not, add it
REPOSITORIES_FIELD=`cat $COMPOSER_HOME/config.json | jq '.repositories'`
if [ "$REPOSITORIES_FIELD" == "null" ]; then
    echo "Repositories field not present. Creating..."
    cat $COMPOSER_HOME/config.json | jq '.repositories=[]' > result.json
    mv -f result.json $COMPOSER_HOME/config.json
fi

# check if repository entry already exists
DOES_ENTRY_EXIST=`cat $COMPOSER_HOME/config.json | jq --arg type $WERCKER_ADD_PRIVATE_COMPOSER_REPOSITORIES_TYPE --arg url $WERCKER_ADD_PRIVATE_COMPOSER_REPOSITORIES_URL '.repositories | map(contains({"type": $type, "url": $url})) | any'`
if [ "$DOES_ENTRY_EXIST" == "true" ]; then
    echo "Private repository entry already present... ignoring."
else
    # add repository entry
    cat $COMPOSER_HOME/config.json | jq --arg type $WERCKER_ADD_PRIVATE_COMPOSER_REPOSITORIES_TYPE --arg url $WERCKER_ADD_PRIVATE_COMPOSER_REPOSITORIES_URL  '.repositories |= .+ [{"type": $type, "url": $url}]' > result.json
    mv -f result.json $COMPOSER_HOME/config.json
fi
