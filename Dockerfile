FROM mcr.microsoft.com/mssql/server
# https://hub.docker.com/_/microsoft-mssql-server
# ARG DEBIAN_FRONTEND=noninteractive
ENV ACCEPT_EULA=Y
RUN apt-get -y update 
RUN apt-get install -y dialog apt-utils 
RUN apt-get install -y libreadline6 libreadline6-dev 
RUN apt-get install -y curl 
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - 
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list | tee /etc/apt/sources.list.d/mssql-server.list 
RUN apt-get -y update 
RUN apt-get install -y mssql-server-fts 
# RUN systemctl restart mssql-server.service
# WORKDIR /usr/src/app
# COPY . /usr/src/app

# # Grant permissions for the import-data script to be executable
# RUN chmod +x /usr/src/app/import-data.sh

# WORKDIR /usr/src/app

# CMD /bin/bash ./import-data.sh
# WORKDIR /temp/scripts
# COPY test.sql .

# CMD /bin/bash


# docker build .