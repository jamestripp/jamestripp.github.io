# Profile

## Build environment

The build environment is in a docker container on the github container repository.

To download the image run the below.

```bash
docker pull ghcr.io/jamestripp/rstudio-blogdown:main
```

The dockerfile is in the repository github.com/jamestripp/rstudio-blogdown. There is a github action which builds and pushes the container on commit.