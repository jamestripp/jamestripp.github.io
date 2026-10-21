[Skip to main content](#quarto-document-content)

# Quarto: a library to run them all?

Talks & workshops

Workshop delivered at RSE conf 2022

Author

Carlos Cámara-Menoyo, Cagatay Turkay, James Tripp

Published

September 7, 2022

I co-delivered a workshop exploring the Quarto library at the RSE conference 2022. The slides and abstract are below.

### Slides

Quarto:\
A library to run them all?
==========================

RSE Conference 2022 \| Newcastle Upon Tyne

Carlos Cámara-Menoyo \| Cagatay Turkay \| James Tripp

Centre for Interdisciplinary Methodologies (University of Warwick) \| IT Services (University of Warwick)

# Goals

- Introduce Quarto
- Facilitate you working with Quarto
- Have a discussion evaluating Quarto

# Plan

1.  Introductions
2.  Introduction to Quarto
3.  Use cases
    1.  Group formation and cases
    2.  Working in groups - with break!
4.  Large group Discussion
5.  Farewell

# Introductions

Let’s get to know each other

## About us

**Carlos Cámara**

*Research Software Engineer*

<carlos.camara@warwick.ac.uk>

- R user
- Interested in reproducibility, open science, geospatial data, visualisation

**Cagatay Turkay**

*Professor*

<cagatay.turkay@warwick.ac.uk>

- Python user
- Interested in visualisation and data science

**James Tripp**

*Research Software Engineer*

[james.tripp@warwick.ac.uk](mailto:cagatay.turkay@warwick.ac.uk)

- Python, R and PHP user
- Interested in research software engineering, data science and digital humanities

He uses Python and I love using R and we both work together. It is partially because of that that we decided to explore using quarto in our Data Science and Data Visualisation classes. This workshop is, then, an excuse to force us using it and learn by doing.

## About you

Let us know about your **prior knowledge about quarto**

1.  Experts
2.  Some degree of knowledge
3.  Never used before, but I know what it is
4.  I do not know what it is

About your **preferred programming language**:

- R \| Python \| Julia

About **this workshop**: Have you had time to read cases’ descriptions?

Usually, we’d be asking you to introduce yourselves, but given the large number of attendees, we have done that via [this github issue](https://github.com/WarwickCIM/quarto-workshop/issues/17).

## Disclaimer

**About us**

We are not Quarto experts!

We are not affiliated in any way to Quarto or Posit. We do not have any commercial interest.

We are just quarto users who want to share our progress and engage with other users in a co-creation process with an attitude of *healthy skepticism*.

**About the session**

This is not (just) a talk about quarto. Others have done it very well before¹. We will be presenting quarto’s main claims and putting them to a test (with your help).

**About the slides**

These slides have been created with quarto (of course!)

1.  See references’ section

# Quarto

A brief overview to quarto

(that’s why we are here, right?)

## Preamble

- Agreement on importance of Literate programming (concept) and notebooks (artifacts)
- Lots of different solutions, mostly language specific

### R: Rmarkdown

- Markdown with configurable code blocks
- Focus on R (but does support other languages [see here](https://bookdown.org/yihui/rmarkdown/language-engines.html))
- Can compile to other formats:
  - natively
  - bookdown, blogdown, …

### Python: Jupyter notebook

- Single `JSON` file containing code, text and output
- Kernels for many programming languages
- Can compile to other formats:
  - Jupyter book, nbconvert, …

This might be about to change with quarto

But before actually speaking about quarto, we wanted to highlight two items.

first, the shared agreement in the DS community about the importance of literate programming …

And second, that the way this has been approached greatly differs based on the programming language you may be using.

## What’s quarto?

According to their creators¹ ([Posit](https://posit.co/) -formerly RStudio)):

- “Open-source scientific and technical publishing system built on Pandoc” - [quarto.org](https://quarto.org/)
- “Code output via integration with Jupyter, Knitr, and Observable” - [GitHub Repo](https://www.rstudio.com/blog/announcing-quarto-a-new-scientific-and-technical-publishing-system/)

From a technical standpoint (Adapted from [Mock, 2022](https://jthomasmock.github.io/quarto-2hr-webinar/materials/01-intro-quarto.html#/so-what-is-quarto)):

> Quarto is a **command line interface** (CLI) that **renders** mixed-format files (`.ipynb`/Jupyter notebook) OR plain text files (`.qmd`, `.rmd`, `.md`) into different **outputs** (reports, books, websites, presentations…) , which can be in different **formats** (PDF/Word/HTML…) .

So, what’s quarto, then?

According to Posit (formerly known as Rstudio), the creators of quarto, quarto is the next generation of Rmarkdown…

Ok, this is how quarto is marketed, but this may not be clear to most of us, so we tried to define it from a more technical point of view.

Adapting from Mock, quarto is…

1.  Development started in January 2021 and is under heavy development (weekly releases)

## How does it work? (Overview)

From a `qmd` file…

```` numberSource
---
title: "ggplot2 demo"
author: "Norah Jones"
date: "5/22/2021"
format: 
    html:
    fig-width: 8
    fig-height: 4
    code-fold: true
---

## Air Quality

@fig-airquality further explores the impact of temperature 
    on ozone level.

```{r}
#| label: fig-airquality
#| fig-cap: Temperature and ozone level.
#| warning: false
library(ggplot2)
ggplot(airquality, aes(Temp, Ozone)) + 
    geom_point() + 
    geom_smooth(method = "loess"
)
```
````

Anatomy:

- Frontmatter defintions
- Content
  - Text (Markdown with batteries)
  - Code blocks

… to its output.

In this case, an **html document** (line 6) with text, code (folded -see line 9) and output.

Does this look familiar to you?

We’ve seen what quarto is, so now let’s focus on how it does its thing.

At this point, if there’s someone who has used Rmd before may be thinking. But Carlos, you’ve jjust defined how rmd works!

And aside from minor changes in the frontmatter, that’s true

So probably the next slide will bring some light on the differences

## How does it work?

This is what happens behind the scenes for single file documents:

> **NOTE:**

At this point, if there’s someone who has used Rmd before may be thinking. But Carlos, you’ve jjust defined how rmd works!

And aside from minor changes in the frontmatter, that’s true

So probably why this diagram will bring some light on the differences

## How can quarto be called?

From CLI:

``` numberSource
quarto --help

  Usage:   quarto 
  Version: 0.9.563
                  

  Description:

    Quarto CLI

  Options:

    -h, --help     - Show this help.                            
    -V, --version  - Show the version number for this program.  

  Commands:

    render          [input] [args...]   - Render input file(s) to various document types.   
    preview         [file] [args...]    - Render and preview a document or website project. 
    serve           [input]             - Serve a Shiny interactive document.               
    create-project  [dir]               - Create a project for rendering multiple documents 
    convert         <input>             - Convert documents to alternate representations.   
    pandoc          [args...]           - Run the version of Pandoc embedded within Quarto. 
    run             [script] [args...]  - Run a TypeScript, R, Python, or Lua script.       
    tools           <command> [tool]    - Installation and update of ancillary tools.       
    check           [target]            - Verify correct functioning of Quarto installation.
    help            [command]           - Show this help or the help of a sub-command.  
```

From your favourite IDE:

## What can quarto do?

## Documents

## Presentations

## Projects

Visit [Quarto’s gallery](https://quarto.org/docs/gallery/) for more examples

## What can quarto do? (Interactivity)

Additionally, we can add interactivity¹ to the previous outputs:

- Web browser:
  - **htmlwidgets** ([Documentation](https://quarto.org/docs/interactive/widgets/htmlwidgets.html))
  - **jupyterwidgets** ([Documentation](https://quarto.org/docs/interactive/widgets/jupyter.html))
  - **ObservableJS** ([Documentation](https://quarto.org/docs/interactive/ojs/))
- Server side:
  - **shiny** ([Documentation](https://quarto.org/docs/interactive/shiny/))

``` numberSource
library(leaflet)

leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lat=54.9734625, lng=-1.6242486, popup="RSECon 2022")
```

1.  More info: [Interactivity overview (Official Guide)](https://quarto.org/docs/interactive/)

## Key features

- Language agnostic (Works with `R`, `Python`, `Julia`, `Observable`):
  - Can combine different languages in a single document
  - Same syntax
  - One command line

- IDE Agnostic (Integrations - see [getting started](https://quarto.org/docs/get-started/))
  - RStudio
  - Visual Studio Code/VS Codium
  - Jupyter

- Diverse outputs
  - Formats: `pdf`, `html`, `epub`, `docx`…
  - Media: articles, presentations (like this one!), blogs, websites, books…
- Sensible defaults
  - Bootstrap

## Key features

Most of the “not so great” features derive from being under heavy development:

- New features to come (to be at par with knitr and to surpass it)
  - No new features added to `Rmarkdown`¹
- Not as mature as other solutions
- Weekly releases
  - Different versions, different results

1.  For more info about replacing Rmarkdown with quarto, you can refer to [these FAQs on quarto’s webiste](https://quarto.org/docs/faq/rmarkdown.html) and Yihui Xie’s blog post [With Quarto Coming, is R Markdown Going Away? No](https://yihui.org/en/2022/04/quarto-r-markdown/)

## Further references

These references introduce quarto way more extensively than we just did:

- James Goldie: [*Quarto: Create beautiful documents with R, Python, Julia and Observable*](https://runapp2022.talks.jamesgoldie.dev/#/james-goldie)
- [*Hello Quarto! A Quarto Chat with NASA Openscapes, co-hosted with R-Ladies Santa Barbara*](https://www.openscapes.org/blog/2022/06/22/hello-quarto/)
  - Mine Çetinkaya-Rundel and Julia Stewart Lowndes: [*Hello quarto*](https://mine.quarto.pub/hello-quarto/#/hello-quarto-title)
- Tom Mock: [Getting started with Quarto: *2-hour workshop on quarto*](https://jthomasmock.github.io/quarto-2hr-webinar/)
  - [Video Recording](https://www.youtube.com/watch?v=yvi5uXQMvu4)
  - [Slides](https://jthomasmock.github.io/quarto-2hr-webinar/materials/01-intro-quarto.html)

# Use cases

Your turn, now

## Group formation and cases

1.  Choose a case from the ([case list](https://github.com/WarwickCIM/quarto-workshop/labels/cases)) on GitHub

2. Each case has a place in the room. Please go to the place for your corresponding case.

3. Form groups of 4 or 5. Say hi to your new friends

4. Choose **Documentors** and **Spokesperson**

## Work on your case

1.  Install quarto’s binaries: <https://quarto.org/docs/get-started/>
2.  Fork [this repository](https://github.com/WarwickCIM/quarto-workshop/)

3.  Create a new folder for your case under `cases/`
4.  Copy the template from [`cases/template/documentation_template.qmd`](https://github.com/WarwickCIM/quarto-workshop/blob/main/cases/template/documentation_template.qmd) to your folder, which will be used to document the process
5.  Make any changes needed

6.  Commit any changes
7.  Submit Pull Request to the [Workshop’s GitHub repo](https://github.com/WarwickCIM/quarto-workshop/)

> **IMPORTANT:**

## Let the games begin!

# 

See you at 16:00

# Reconvene!

For the large group discussion

Ok, now it’s time to reconvene

# RSECon-vene?

For the large group discussion

…or should we say “RSECon-vene?”

Now seriously: this is the time to share your thoughts after having worked with quarto for a while.

## Group Feedback

- Spokesperson from each group
- What did you do? What were your thoughts?

## Group Discussion

Some ideas (but feel free to add yours!):

- How are you going to use quarto in the future?
- If not, why not?
- What’s missing?

We can continue the discussion in Github’s repo -discussion’s section

# What’s next?

If you’ve enjoyed the workshop and want to keep exploring quarto, there are some things that can be done:

- Tell us how we did (fill in [this form](https://forms.office.com/Pages/ResponsePage.aspx?id=vc-6Ce9HZUSSZTVG8ur2vAQZ2Cjv6lBImQbzP-oFJcdUREEwWjIwU1YxQkowMURYMVpUVUxCRjhGMy4u))
- We can continue the discussion on the repos’ [discussions section](https://github.com/WarwickCIM/quarto-workshop/discussions)
- Keep in touch with us!
- Keep extending the use cases and convert this into a repository for quarto use cases
- …

# Thanks!

**Carlos Cámara**, carlos.camara@warwick.ac.uk, [https://carloscamara.es/en](https://carloscamara.es/en)

**James Tripp**, james.tripp@warwick.ac.uk

**Cagatay Turkay**, cagatay.turkay@warwick.ac.uk

![](images/logo_black.png)

https://bit.ly/rsecon22-quarto

### Abstract

Using literate programming is a widespread practice amongst data scientists. This practice not only encourages data scientists to produce transparent, rich and reflective accounts of their analysis without the extra overhead of switching between tools, but also leads to artefacts (i.e., notebooks) that are increasingly becoming a medium for dissemination, reproducibility and education. Rmarkdown or Jupyter notebooks, are two of the most well known and used options. While both solutions can be used with multiple programming languages, the decision of whether to use one or the other is almost certain to be exclusively based on that. At least until now, with Quarto being mature enough to become a game-changer.

Quarto is a language-agnostic software based on Pandoc to render files combining markdown and code into multiple ranges of formats and outputs. As a result, it can be used with either R, Python or Julia without any other dependencies.

This collaborative workshop will be structured as follows:

- a brief theoretical introduction and instructions;
- a task that participants may choose from the different use cases provided (i.e. generating a single document, migrating from Rmarkdown or Jupyter, creating a book or generating interactive content); and
- a group discussion and conclusions.

Participants in this workshop have fun while gaining enough depth of breath and practice to evaluate how feasible it is to use Quarto in different scenarios and, ultimately, if it can become the one tool for authoring reproducible scientific or technical documents, regardless of your language of choice.
