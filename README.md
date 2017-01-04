# add-private-composer-repositories
A wercker step that configures Composer to load the private AudienceReport PHP repositories.

The step requires composer to be installed on your docker image and COMPOSER_HOME to be set.

## Example

```
steps:
    - audienceproject/add-private-composer-repositories
```