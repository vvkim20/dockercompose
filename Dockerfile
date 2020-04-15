FROM ubuntu:16.04
ARG DB_PASSWORD
ENV SA_PASSWORD=${DB_PASSWORD}
ENV ACCEPT_EULA=Y
ENV CONFIG_PATH /usr/config/sqlserver

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -yq curl apt-transport-https && \
    # Get official Microsoft repository configuration
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2019.list | tee /etc/apt/sources.list.d/mssql-server.list && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list && \
    apt-get update && \
    # Install SQL Server from apt
    apt-get install -y mssql-server && \
    # Install optional packages
    apt-get install -y mssql-server-ha && \
    apt-get install -y mssql-server-fts && \
    apt-get install -y mssql-tools unixodbc-dev && \
    apt-get install -y locales && \
    # Cleanup the Dockerfile
    apt-get clean && \
    rm -rf /var/lib/apt/lists

RUN locale-gen en_US.UTF-8

# Create a config directory
RUN mkdir -p ${CONFIG_PATH}
WORKDIR ${CONFIG_PATH}

# Bundle config source
COPY . /usr/config

# Grant permissions for to our scripts to be executable
RUN chmod +x configure-db.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT "./entrypoint.sh"

# https://github.com/microsoft/mssql-docker/tree/master/linux/preview/examples/mssql-customize
# https://github.com/Microsoft/mssql-docker/blob/master/linux/preview/examples/mssql-agent-fts-ha-tools/Dockerfile
