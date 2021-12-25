FROM rocker/rstudio

# Install R packages
RUN install2.r --error \
    blogdown \
    markdown \
    miniUI \
    rstudioapi