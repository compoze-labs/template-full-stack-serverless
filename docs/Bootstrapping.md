# Bootstrapping Your Repository

## Rename your project
Update the root `package.json` "`name`" to be your projects name. The bootstrapping routine will go through and update the places that this name will need to be updated. Also update the `awsprofile` value to be a unique profile for your team.
```json
{
    "name": "templatenametoreplace", //change this
    "awsprofile": "YOUR_TEAMS_PROFILE", //change this
    "description": "",
    //...
}
```
> We use `awsprofile` on manual tasks rather than relying on `AWS_PROFILE` environment, as to avoid accidentally spinning up infrastructure in the wrong accounts.

## Run bootstrap
```bash
npm run bootstrap
```
> Assumes you are running `./batect shell` or have required CLIs (see `.batect/Dockerfile.shell` for manual installation)