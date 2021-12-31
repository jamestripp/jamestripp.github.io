---
title: Devcontainers
author: 'James Tripp'
date: '2021-12-31'
slug: devcontainers
categories: [software]
tags: [containers, github, continuous integration]
---

How can we create a reproducible blogdown environment? I encountered an error in my previous attempt. In this post I detail my current solution which uses devcontainers.

## Devcontainers

Devcontainers are a vscode feature. There are two files. A dockerfile with instructions for building a container and a devcontainer.json file with various VSCode settings. VSCode deals with creating these files, building the container and then opening up VSCode *within* the container.

Essentially, a portable VSCode environment. A rather fine video showing how to get started with devcontainers is below.


<iframe width="560" height="315" src="https://www.youtube.com/embed/FvUpjdWnibo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen data-external="1"></iframe>