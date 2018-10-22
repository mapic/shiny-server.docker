FROM ubuntu:16.04

LABEL maintainer="knutole@mapic.io"
LABEL repository="https://github.com/mapic/shiny-server.docker"
LABEL version="panda"

WORKDIR /home/

# 0. INSTALL DEPENDENCIES & UPGRADE
# -
# 0.1 install deps
RUN apt-get update -y
RUN apt-get install -y sudo software-properties-common apt-transport-https fish git wget curl htop nano net-tools iputils-ping 
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
RUN apt-get update -y
RUN apt-get install -y nodejs
RUN npm install -g forever

# 0.2 upgrade 
RUN apt-get upgrade -y


# 1. INSTALL R
# -
# 1.1 get secure APT key
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

# 1.2 add sources
# RUN sudo add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial/'
RUN sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial-cran35/'

# 1.3 update sources
RUN sudo apt-get update -y

# set R version
ENV R_BASE_VERSION 3.5.1


# 1.4. get depdendencies
RUN apt-get install -y libcurl4-openssl-dev libssl-dev libssh2-1-dev libxml2-dev

# 1.4 install R
# RUN sudo apt-get install -y r-base r-base-dev r-recommended
RUN sudo apt-get install -y r-base=${R_BASE_VERSION}-* \
    r-base-dev=${R_BASE_VERSION}-* \
    r-recommended=${R_BASE_VERSION}-*

# 1.5 upgrade R
RUN sudo apt-get upgrade -y

# 1.6 configure R
RUN echo 'options(download.file.method = "wget")' >> /etc/R/Rprofile.site 


# 2. INSTALL SHINY SERVER
# -
# 2.1 install dependencies
RUN sudo apt-get install -y gdebi-core

# 2.2 download latest package
RUN sudo wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.9.923-amd64.deb

# 2.3 intall shiny server
RUN sudo gdebi -n shiny-server-1.5.9.923-amd64.deb

# 2.4 install shiny R packages
ADD ./install-r-packages.sh /home/
ADD ./r-packages.list /home/
RUN bash install-r-packages.sh


# 3. CONFIGURE
# -
# 3.1 expose ports
EXPOSE 3838

# 3.2 set the locale
RUN apt-get clean && apt-get -y update && apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8   


# 3.3 add entrypoint
ADD ./docker-entrypoint.sh /home/

# 3.4 add default command
CMD ["bash", "/home/docker-entrypoint.sh"]

