# templatenametoreplace
> See [Bootstrapping.md](./docs/Bootstrapping.md) for first time template tasks.

## Getting Started (with container)
* Install `java` (ensure `java -version` works)
* Install `docker` (ensure `docker ps` works)
    * Mac: https://stackoverflow.com/questions/65601196/how-to-brew-install-java/70786302#70786302
```bash
./batect shell

pnpm install
```

## Getting Started (without container)
* See list of CLIs tested under [`Dockerfile.shell`](./.batect/Dockerfile.shell) and ensure each CLI works properly

```bash
pnpm install
```