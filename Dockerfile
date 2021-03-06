FROM rocker/verse
MAINTAINER "Carl Boettiger and Dirk Eddelbuettel" rocker-maintainers@eddelbuettel.com

## Install some external dependencies. 
RUN apt-get update \
  && apt-get install -y --no-install-recommends  \
    default-jdk \
    default-jre \
    gdal-bin \
    icedtea-netx \
    libatlas-base-dev \
    libcairo2-dev \
    libhunspell-dev \
    libgeos-dev \
    libgsl0-dev \
    librdf0-dev \
    libmysqlclient-dev \
    libpq-dev \
    libsqlite3-dev \
    librsvg2-dev \
    libv8-dev \
    libxcb1-dev \
    libxdmcp-dev \
    libxml2-dev \
    libxslt1-dev \
    libxt-dev \
    mdbtools \
    netcdf-bin \
    qpdf \
    ssh \
    vim \
  && R CMD javareconf \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## Install the tidyverse package, RStudio pkg dev (and some close friends). 
RUN install2.r \
  -r 'http://www.bioconductor.org/packages/release/bioc' \
  -r 'https://cran.rstudio.com' \
  --dep TRUE  \
  tidyverse devtools profvis rticles bookdown rmdshower \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## httr authentication uses this port
EXPOSE 1410
ENV HTTR_LOCALHOST 0.0.0.0
