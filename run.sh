#!/bin/bash
mkdir $COMPOSER_HOME
echo '{\n\
	"repositories": [{\n\
		"type": "vcs",\n\
    "url": "git@bitbucket.org:AudienceReportTeam/audiencereport-php-ns.git"\n\
	}, {\n\
		"type": "vcs",\n\
		"url": "git@bitbucket.org:AudienceReportTeam/adt-aws-swf-fluent.git"\n\
	}]\n\
}\n'\ >> $COMPOSER_HOME/config.json