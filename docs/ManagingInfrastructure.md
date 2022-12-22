# Infrastructure

## Updating
```
pnpm update-infra
```
> Updates are idempotent -- meaning, it will create new stacks, or update stacks it already created.

## Nuking
```
pnpm nuke
```
> Destroys all infrastructure and runs all sub `nuke` commands in sub-package.jsons

## Destroying One Component
This may be useful if you wish to tear down only one part of your system. For example, if you wanted to rename your API to be something else, then you may wish to just tear down the infrastructure for the API, rename it, and then stand it back up again with a new name.
```
pnpm nuke <component>
```
> Destroys the infrastructure in `infrastructure/component.yml` as well as runs any `nuke` command in the sub-package.json.
