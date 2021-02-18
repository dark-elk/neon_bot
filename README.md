# Ruby boilerplate

## Basic repo bootstrap

1. Copy this repo to your own location
1. Setup appropriate project name and project repo name:
    1. here in Readme instead of `Ruby boilerplate`
    1. in chart/Chart.yaml
    1. project repo in chart/values.yaml
    1. `project_name` in system/boot/settings.rb
    1. `KUBE_NAMESPACE` and `HELM_RELEASE_NAME` in .gitlab-ci.yml
1. Push to your repo
1. In Gitlab go to Settings -> CI/CD -> Runners disable shared runners and enable all custom igooods runners
1. In Gitlab go to CI/CD -> Pipelines and run manual action named `build-ci-image`

## Deployment bootstrap

1. In order to build and push an image, create a Deploy Token (Settings -> Repository -> Deploy Tokens), named `gitlab-deploy-token`
1. In order to deploy, go to CI/CD -> Variables    
    1. create `production` and `staging` environments in Operations -> Environments
    1. create a variable of type File named `APP_ENV_FILE` for both environments
    1. fill variables with actual values as described in .env.development.sample
1. Restart the pipeline to ensure it has passed

## Local actions

1. copy `.env.development.sample` to `.env.development` and fill your actual variable values

# Console

bin/service console           # Start IRB session
bin/service consumer          # Start rabbitmq consumer server
bin/service que               # Start que server
bin/service server            # start http server
bin/service version           # Print version

## DB rake commands

```
# creates a new migration file
$ bundle exec rake "db:create_migration[migration_name]"

# runs pending migrations
$ bundle exec rake db:migrate
$ PROJECT_ENV=test bundle exec rake db:migrate

# rolls the schema back to the previous version
$ bundle exec rake db:rollback

# perform db:rollback and db:migrate
$ bundle exec rake db:redo

# display status of migrations
$ bundle exec rake db:migrate:status

# cleans the database
$ bundle exec rake db:clean

# drops tables and re-runs migrations
$ bundle exec rake db:reset
```

## Github Flow

The project uses the [Github Flow](https://guides.github.com/introduction/flow/).
