[Skip to main content](#quarto-document-content)

# R and Docker

Talks & workshops

Presentation to the Warwick R User Group (WRUG)

Author

James Tripp

Published

September 15, 2022

I will be presenting and introduction to Docker and Containers with R to the Warwick User Group. Slides and the abstract is below.

### Slides

# R and Docker

Warwick R User Group

James Tripp

Senior Research Software Engineer, IT Services (University of Warwick)

# Who am I?

**James Tripp**

*Research Software Engineer*

<james.tripp@warwick.ac.uk>

- Researcher in Cognitive Science
- Senior Academic Technologist @ [Interdisciplinary Centre](https://warwick.ac.uk/fac/cross_fac/cim/)
- Senior Research Software Engineer @ [IT Services](https://warwick.ac.uk/fac/arts/research/digitalhumanities/team/)

# Plan

- Why?
- Docker?
- Next Steps

# Why?

## Developers

- Software developers sometimes wrote code which only ran on their machine
- That could be a problem

## Developers

## Developers

- Developers could build and update *images*
- *Images* are stored in a registry
- Production servers download *images*
- Copies of these *images* called *containers* are used in production

## Researchers

How does this help research?

- Aids computational reproducibility ([Boettiger 2015](#/references))

- Allows other to run code without having to install lots of dependencies ([Eglen et al. 2017](#/references))

- Language agnostic and used widely ([Pittard and Li 2020](#/references))

- Provides the basis for technologies like the research compendium ([Marwick, Boettiger, and Mullen 2018](#/references)), binder ([“Get Started with Binder Binder 0.1b Documentation,” n.d.](#/references)) and dev containers ([Smith 2022](#/references))

# Docker

## What?

## What?

## What?

## What?

## What?

## What?

## R images on DockerHub

- The R project has an [official r-base image](https://hub.docker.com/_/r-base/)

- [Rocker Project](https://rocker-project.org/images/) has lots of images:

    -   rocker/r-ver - alternative to r-base
    -   rocker/rstudio - R and RStudio
    -   rocker/tidyverse- R and tidyverse packages
    -   rocker/shiny - Shiny server built in
    -   many others

## Base image

To use the official image

``` numberSource
docker run --rm -ti r-base
```

1.  The r-base image downloaded

2.  Container created from image

3.  Terminal enters container

> **NOTE:**

## RStudio image

``` numberSource
docker run --rm -ti -e DISABLE_AUTH="true" -p 8787:8787 rocker/rstudio
```

- Downloads image, creates and terminal enters container

- The container provides access to RStudio via localhost:8787

- You now have an isolated RStudio container running

> **NOTE:**

## Custom images

- Docker images are created from dockerfiles. A sample dockerfile is below¹.

``` numberSource
FROM r-base
COPY . /usr/local/src/myscripts
WORKDIR /usr/local/src/myscripts
CMD ["Rscript", "myscript.R"]
```

- To build the image, go to the folder containing the dockerfile and run.

``` numberSource
docker build -t jamestripp/myimage .
```

- Finally, to create a container and jump into it.

``` numberSource
docker run --rm -ti jamestripp/myimage
```

> **NOTE:**

1.  Sample taken from <https://hub.docker.com/_/r-base/>

## Local files

- Copying files when the image is created. Baked into the image.

``` numberSource
FROM r-base
COPY . /usr/local/src/myscripts
WORKDIR /usr/local/src/myscripts
CMD ["Rscript", "myscript.R"]
```

- Volumes are folders on your local file system which are accessible to a container

``` numberSource
# MacOS and Linux
docker run --rm -ti -e DISABLE_AUTH="true" -p 8787:8787 -v  $(pwd):/home/rstudio/data rocker/rstudio
# Windows
docker run --rm -ti -e DISABLE_AUTH="true" -p 8787:8787 -v  absolute_path:/home/rstudio/data rocker/rstudio
#May work on Windows
docker run --rm -ti -e DISABLE_AUTH="true" -p 8787:8787 -v  %cd%:/home/rstudio/data rocker/rstudio
```

Where absolute_path is the full Windows path

# Example

## Fortune

myscript.R

``` numberSource
library(fortunes)

print(fortune())
print(fortune())
```

dockerfile

``` numberSource
FROM r-base
COPY . /usr/local/src/myscripts
WORKDIR /usr/local/src/myscripts
RUN ["install2.r", "fortune"]
CMD ["Rscript", "myscript.R"]
```

Build and run it

``` numberSource
docker build -t jamestripp/fortune .
docker run --rm -ti jamestripp/fortune
```

## Fortune

## Other examples

- [RMarkdown](https://jlintusaari.net/how-to-compile-r-markdown-documents-using-docker/)

- [Shiny apps](https://github.com/rsangole/user2022-r-for-docker/tree/main/04-docker-and-r/05-deploy-shiny-in-docker)

- [Deploying models](https://github.com/rsangole/user2022-r-for-docker/tree/main/04-docker-and-r/04-deploy-models-in-docker)

## To consider

- Changes in the base image can influence the images build upon them
- Ensure you use trustworthy images such as Rocker ([Boettiger and Eddelbuettel 2017](#/references))

- Smaller images with very little software may be preferable as these are easier to maintain ([Gruening et al. 2019a](#/references))

- Containers are, perhaps, only part of a reproducible workflow([Mölder et al. 2021](#/references); [Gruening et al. 2019b](#/references))
- Do we need to replicate the entire computing environment? Perhaps automagic or renv, which captures the R version and libraries, is all we need… (see the previous [WRUG presentation by Carlos Camara Menoyo](https://ccamara.github.io/wrug-depedencies/slides.html#1))

# Next steps

## Learning materials

- Look through the [R Blogger posts on Docker](https://cse.google.com/cse?cx=005359090438081006639%3Apaz69t-s8ua&ie=UTF-8&q=docker&sa=Go&bIDiEKaSr=%5BNwX%5DavgpyM&JtlBfjh=JlitU.M3&BNXYvMTtg=m6Py%40WO3Y0u&bIDiEKaSr=%5BNwX%5DavgpyM&JtlBfjh=JlitU.M3&BNXYvMTtg=m6Py%40WO3Y0u&bIDiEKaSr=%5BNwX%5DavgpyM&JtlBfjh=JlitU.M3&BNXYvMTtg=m6Py%40WO3Y0u)

- Work through the UserR2022 workshop by rsangole ([repo](https://github.com/rsangole/user2022-r-for-docker), [blog post](https://www.r-bloggers.com/2022/06/user2022-best-practicesfor-shiny-apps-with-docker-and-more/))

- Read through the docker section in the [DevOps for Data Science](https://do4ds.com/chapters/sec1/docker.html) book

## Papers

- Some R packages are mentioned in Nüst, Eddelbuettel, et al. ([2020](#/references)). I was not able to get these packages working
  - [Stevedore](https://github.com/richfitz/stevedore) - Sends commands to Docker. Required reticulate and the Python docker module. Recieved the error ‘Did not find required python module ’docker’’. Issue reported and not addressed in the past year…

  - [Dockyard](https://github.com/thebioengineer/dockyard) - Aims to help you create and run a container. Last commit was 3 years ago and the example code on the github page does not work…

  - [Dockermachine](https://github.com/cboettig/dockermachine) - Last updated 5 years ago.

- Nüst, Sochat, et al. ([2020](#/references)) outlines 10 rules for creating dockerfiles, talks about good practice and sign posts other tools

- Peikert and Brandmaier ([2021](#/references)) offer a workflow for rendering markdown documents which includes a make file for dependencies

- Not an exhaustive list

## Tools

[**Binder**](https://github.com/binder-examples/r)

Run a docker container on a remote server. Place a button on your public github repo README.md.

[**ShinyProxy**](https://www.shinyproxy.io/)

Spins up shiny containers with one container per user (see the [R Bloggers post](https://www.r-bloggers.com/2019/11/deploying-r-shiny-apps-using-shinyproxy-on-windows-10-2/))

# Questions?

# References

https://jamestripp.github.io/RandDocker/

Boettiger, Carl. 2015. “An Introduction to Docker for Reproducible Research.” *ACM SIGOPS Operating Systems Review* 49 (1): 7179. <https://doi.org/10.1145/2723872.2723882>.

Boettiger, Carl, and Dirk Eddelbuettel. 2017. “An Introduction to Rocker: Docker Containers for R.” *The R Journal* 9 (2): 527–36. <https://journal.r-project.org/archive/2017/RJ-2017-065/index.html>.

Eglen, Stephen J., Ben Marwick, Yaroslav O. Halchenko, Michael Hanke, Shoaib Sufi, Padraig Gleeson, R. Angus Silver, et al. 2017. “Toward Standard Practices for Sharing Computer Code and Programs in Neuroscience.” *Nature Neuroscience* 20 (6): 770–73. <https://doi.org/10.1038/nn.4550>.

“Get Started with Binder Binder 0.1b Documentation.” n.d. <https://mybinder.readthedocs.io/en/latest/introduction.html>.

Gruening, Bjorn, Olivier Sallou, Pablo Moreno, Felipe da Veiga Leprevost, Hervé Ménager, Dan Søndergaard, Hannes Röst, et al. 2019a. “Recommendations for the Packaging and Containerizing of Bioinformatics Software.” <https://doi.org/10.12688/f1000research.15140.2>.

———, et al. 2019b. “Recommendations for the Packaging and Containerizing of Bioinformatics Software.” <https://doi.org/10.12688/f1000research.15140.2>.

Marwick, Ben, Carl Boettiger, and Lincoln Mullen. 2018. “Packaging Data Analytical Work Reproducibly Using r (and Friends).” *The American Statistician* 72 (1): 80–88. <https://doi.org/10.1080/00031305.2017.1375986>.

Mölder, Felix, Kim Philipp Jablonski, Brice Letcher, Michael B. Hall, Christopher H. Tomkins-Tinch, Vanessa Sochat, Jan Forster, et al. 2021. “Sustainable Data Analysis with Snakemake.” *F1000Research* 10 (April): 33. <https://doi.org/10.12688/f1000research.29032.2>.

Nüst, Daniel, Dirk Eddelbuettel, Dom Bennett, Robrecht Cannoodt, Dav Clark, Gergely Daróczi, Mark Edmondson, et al. 2020. “The Rockerverse: Packages and Applications for Containerisation with R.” *The R Journal* 12 (1): 437–61. <https://journal.r-project.org/archive/2020/RJ-2020-007/index.html>.

Nüst, Daniel, Vanessa Sochat, Ben Marwick, Stephen J. Eglen, Tim Head, Tony Hirst, and Benjamin D. Evans. 2020. “Ten Simple Rules for Writing Dockerfiles for Reproducible Data Science.” *PLOS Computational Biology* 16 (11): e1008316. <https://doi.org/10.1371/journal.pcbi.1008316>.

Peikert, Aaron, and Andreas M. Brandmaier. 2021. “A Reproducible Data Analysis Workflow With R Markdown, Git, Make, and Docker.” *Quantitative and Computational Methods in Behavioral Sciences*, May, 1–27. <https://doi.org/10.5964/qcmb.3763>.

Pittard, W. Stephen, and Shuzhao Li. 2020. “The Essential Toolbox of Data Science: Python, R, Git, and Docker.” In, edited by Shuzhao Li, 265–311. Methods in Molecular Biology. New York, NY: Springer US. <https://doi.org/10.1007/978-1-0716-0239-3_15>.

Smith, David. 2022. “Easy r Tutorials with Dev Containers \| r-Bloggers.” <https://www.r-bloggers.com/2022/08/easy-r-tutorials-with-dev-containers/>.

### Abstract

Docker is a container technology which allows you to specify and build a compute environment. You can run the environment on your local machine and both the instructions for creating the environment and the environment itself can be shared. In this talk I will (a) introduce containers, (b) discuss a worked example of using Docker with R, and (c) consider how containers can help us do better research. Hopefully this presentation will help those of you who have never used Docker to consider if you want to use Docker in your own work and where to start.
