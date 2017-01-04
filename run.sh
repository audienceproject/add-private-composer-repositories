#!/bin/bash
echo '{
	"repositories": [{
		"type": "vcs",
        "url": "git@bitbucket.org:AudienceReportTeam/audiencereport-php-ns.git"
	}, {
		"type": "vcs",
		"url": "git@bitbucket.org:AudienceReportTeam/adt-aws-swf-fluent.git"
	}]
}' >> $COMPOSER_HOME/config.json
