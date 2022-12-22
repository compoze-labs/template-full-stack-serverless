# Enabling CICD
> The `base.yml` infrastructure repository creates a deploy user for you in the AWS account associated with the profile you set during the bootstrapping portion. 

**For each subproject (i.e api, ui):**
1. Create an access key and secret key for the deploy user in the AWS account
2. Assign these keys as the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` in the secrets portion underneath Settings > Secrets > Actions.
3. Uncomment the `on: push` in the `<api|ui>.yml` to enable deploying upon push to `main`. 
