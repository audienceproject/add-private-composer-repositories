# add-private-composer-repository
A wercker step that configures Composer to load a private repository.

The step requires: 
 1. jq
 2. Composer to be installed on your docker image and COMPOSER_HOME to be set.
 2. An SSH key to be configured for reading Bitbucket/Github
 3. Bitbucket/Github to be added to the list of known hosts (to avoid interactive prompts during repository cloning)
 
The step takes the following parameters: 
 1. type: the type of the repository
 2. url: the url of the repository

## Example

```
steps:
    - add-ssh-key:
        keyname: BITBUCKET
    - add-to-known_hosts:
        hostname: bitbucket.org
        fingerprint: 97:8c:1b:f2:6f:14:6b:5c:3b:ec:aa:46:46:74:7c:40
        type: rsa
    - audienceproject/add-private-composer-repository@1.0.2:
        type: vcs
        url: git@bitbucket.org:AudienceReportTeam/random-repo-1.git
    - audienceproject/add-private-composer-repository@1.0.2:
        type: vcs
        url: git@bitbucket.org:AudienceReportTeam/random-repo-2.git        
```

Note : If you configure the keyname to be `BITBUCKET`, you need to have the following custom ssh keys configured in either the branch or global environment variables for wercker:

* **BITBUCKET_PUBLIC**: The Bitbucket readonly public SSH key.
* **BITBUCKET_PRIVATE**: The Bitbucket readonly private SSH key.