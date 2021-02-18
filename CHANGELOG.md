### Version 0.1.2

- extracted project_name to settings
- improved datadog APM service names
- old db migration hooks are deleted before running new one
- improved datadog rack middleware so it sends action class name as an APM resource name

### Version 0.1.1

- configured app to send PROJECT_VERSION env var to bugsnag as app_version

### Version 0.1.0

- created basic boilerplate for ruby microservice, deployed to k8s
