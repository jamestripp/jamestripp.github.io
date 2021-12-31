---
title: Container for blogdown?
toc: true
date: '2021-12-27'
slug: container-for-blogdown
categories: [software]
tags: [containers, github, continuous integration]
---

I went on a bit of an adventure. My quest, to create a reproducible environment for making my website using the R Blogdown package.

## Blogdown

The [blogdown](https://bookdown.org/yihui/blogdown/) package is superb. I created this site by installing [Hugo](https://gohugo.io) via

```r
blogdown::install_hugo()
```

and then, in a folder for a github repo, running the below.

```r
blogdown::new_site(theme = 'yihui/hugo-xmin')
```

The xmin theme ([GitHub](https://github.com/yihui/hugo-xmin)) is simple. Keeping it simple allows me to customise and, maybe, fix any future errors.

Then I can open up a new file for creating a post,

```r
blogdown::new_post(title='Container for blogdown?')
```

add the content and generate the site.

```r
blogdown::serve_site()
```

That command will also create a web server process so you can see the website.

### Netify

As an aside, I use the [Netify](https://www.netlify.com/) service to publish the website. The Blogdown package puts the files for the page in a folder called public. I upload all the files created by Blogdown to a GitHub repository. Netify creates a container with a webserver and imports the files in public. There are more details about blogdown and Netify [here](https://bookdown.org/yihui/blogdown/netlify.html).

## Containers

Imagine defining an isolated Linux system using a text file. You can run that system on any Linux, MacOS or Windows machine. The same environment, every, darn time.

Sounds useful, huh?

Containers are that solution. There are several programs for running containers (e.g., [Docker](https://www.docker.com), [Podman](https://podman.io), [Apptainer](https://apptainer.org)). To get started, I suggest using [Docker desktop](https://www.docker.com/products/docker-desktop).

Containers are defined using a Dockerfile. Let's consider a simple example where we extend the Ubuntu bionic docker image and upgrade the packages.

```dockerfile
FROM ubuntu:bionic

RUN apt update
RUN apt -f upgrade
```

Docker can then create an image

```bash
docker build -t our_image .
```

which we will call our_image. Then we can create running copies of this image as we want.

```bash
docker run our_image
```

Running the run command multiple times will create multiple containers from our_image. Each container will be created and destroyed. Containers are destroyed once there are no more running processes. Our container updates the packages and, as there are no other processes, is destroyed.

Other images are configured to continue running.

### Rocker images

There are some excellent images created by the [Rocker Project](https://www.rocker-project.org/images/). These images contain R and RStudio.

I want to build my website within a containerised environment. I could then spin up the container and edit my website. No need to worry about the local install of R. No concerns about the different operating systems. Just a zen-like experience.

Like wandering into the same Japanese Garden. Sitting at the same bench. Constructing medatitive prose.

The below dockerfile should do.

```dockerfile
FROM rocker/rstudio

# Install R packages
RUN install2.r --error \
    blogdown \
    markdown \
    miniUI \
    rstudioapi
```

## GitHub

I want the image on all my machines. I could copy the dockerfile to each machine. Maybe put it in an email. Each modification would be a different dockerfile (dockerfile_final, dockerfile_final_JT, etc.).

That feels like really bad practice.

Like any good research software engineer, I've used GitHub. You can find the dockerfile [here](https://github.com/jamestripp/rstudio-blogdown/blob/main/Dockerfile). Great! My friend(s) can download the repository and run the build command on their machines.

... I think we can do better than that.

### Continuous Integration

GitHub has a feature called [GitHub Actions](https://docs.github.com/en/actions/learn-github-actions). We can set a criteria which, when met, tells GitHub to run a series of actions. For example, running tests or, as in our case, building images from a dockerfile.

Follow some [GitHub documentation](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry), I created a workflow file in the .github/workflow folder called [github_registry.yml](https://github.com/jamestripp/rstudio-blogdown/blob/main/.github/workflows/github_registry.yml). The file instructs GitHub to create an Ubuntu container. In that container, GitHub runs commands to build a container using our dockerfile titled the same as the repository (in our case rstudio-blogdown). The image is then uploaded to the GitHub container repository accessed via ghcr.io.

You can view the results of the latest build [here](https://github.com/jamestripp/rstudio-blogdown/runs/4633497821?check_suite_focus=true).

The image should now be publicly available. If we commit a dodgy change to the container file then we will recieve an email. Awesome.

## Blogdown container

Downloading the image is simple.

```bash
docker pull ghcr.io/jamestripp/rstudio-blogdown:main
```

Runnign the image is pretty straight forward

```bash
docker run --rm -p 8787:8787 -e ROOT=TRUE -e DISABLE_AUTH=true -v $(pwd):/home/rstudio ghcr.io/jamestripp/rstudio-blogdown:main
```

where rstudio server is available in our web browser and we have root access in the container. The directory the command is run in appears as default working directory.

RStudio will appear if you go to 127.0.0.1:8787 in your web browser.

Can we develop in this container? Have we achieved our goal? Well... yes and no. An error is shown in RStudio

```
Error: C stack usage  7975508 is too close to the limit
```

which I have yet to fix. Trying to render any rmarkdown documents is stopped due to us being too close to the C stack limit.

There may be workarounds. I have found an alternative, but that will need to wait for another blog post.

We have learned:

* Blogdown creates websites
* Containers create isolated and reproducible environments
* GitHub allows us easily distribute images