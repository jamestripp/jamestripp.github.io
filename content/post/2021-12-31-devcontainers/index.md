---
title: Dev containers
date: '2021-12-31'
toc: true
slug: devcontainers
categories: [software]
tags: [containers, github, continuous integration]
---

How can we create a reproducible blogdown environment? I encountered an error in my previous attempt. In this post I detail my current solution which uses devcontainers.

## Dev containers

Devcontainers are a vscode feature. There are two files. A dockerfile with instructions for building a container and a devcontainer.json file with various VSCode settings. VSCode deals with creating these files, building the container and then opening up VSCode *within* the container.

Essentially, a portable VSCode environment. The Microsoft documentation can be found [here](https://microsoft.github.io/code-with-engineering-playbook/developer-experience/devcontainers/). I rather enjoy seeing the tech in action; the video below by Luciana Abud from the [Microsoft Developers channel](https://www.youtube.com/channel/UCsMica-v34Irf9KVTh6xx-g) is an excellent example.

<iframe width="560" height="315" src="https://www.youtube.com/embed/FvUpjdWnibo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen data-external="1"></iframe>

## R dev container

There is an R dev container. Microsoft has a variety of MS and community defined dev containers (there is a repo [here](https://github.com/microsoft/vscode-dev-containers/tree/main/containers)). One of these is for R (see [here](https://github.com/microsoft/vscode-dev-containers/tree/main/containers/r)).

The default dev container definition is good. The [json file](https://github.com/microsoft/vscode-dev-containers/blob/main/containers/r/.devcontainer/devcontainer.json) shows us that [Radian](https://github.com/randy3k/radian#:~:text=radian%20is%20an%20alternative%20console%20for%20the%20R,though%20its%20design%20is%20more%20aligned%20to%20julia.) is the R console (a rather nice ipython like console for R). Within VSCode the [r extension](https://marketplace.visualstudio.com/items?itemName=Ikuyadeu.r) and [r debugger](https://marketplace.visualstudio.com/items?itemName=RDebugger.r-debugger) are installed. The [dockerfile](https://github.com/microsoft/vscode-dev-containers/blob/main/containers/r/.devcontainer/Dockerfile) shows us we are building on the rocker image with R v4. A bunch of additional packages are installed, including Python 3 pip, and some [R session watcher](https://github.com/REditorSupport/vscode-R/wiki/R-Session-watcher) options are set.

## Customisation

I did very little to the defaul configuration. Blogdown uses Pandoc to convert markdown files into HTML. I also want to have blogdown installed in R. To do both I added pandoc, pandoc-citeproc and blogdown to the dockerfile. The relevent section of my dockerfile is below.

```dockerfile
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && /bin/bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
    && usermod -a -G staff ${USERNAME} \
    && apt-get -y install \
    python3-pip \
    libgit2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libxt-dev \
    pandoc \
    pandoc-citeproc \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts \
    && python3 -m pip --no-cache-dir install radian \
    && install2.r --error --skipinstalled --ncpus -1 \
    devtools \
    languageserver \
    httpgd \
    blogdown \
    && rm -rf /tmp/downloaded_packages
```

The files for this website are in [this repository](https://github.com/jamestripp/jamestripp-net). All the .devcontainer files are in the [.devcontainer folder](https://github.com/jamestripp/jamestripp-net).

## Wrapup

Are devcontainers a good solution? There are a few things to consider:

* Microsoft designed the solution. Dev containers are a gateway technology for [codespaces](https://visualstudio.microsoft.com/services/github-codespaces/). Who knows what the future holds for dev containers.
* Codespaces ties us to the Docker runtime. There are lots of other container runtimes. The underlying container is defined by rocker, so we might be able to put it onto other runtimes if needed.
* What if the rocker container changes and breaks things? That is a problem. We could create our own image, put that onto the GitHub Container Registry, and then use that as the basis for our dev container.
* We are stuck using VSCode. I quite like VSCode and, being the old R user I am, want there to be plenty of competition for RStudio. I think of it as a positive. Plus, I can write all of my code in one editor.

In sum, using an R dev container seems like a good solution to me. At least for the moment.