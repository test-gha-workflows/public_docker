FROM ubuntu:noble
ARG DEBIAN_FRONTEND=noninteractive
ARG RELEASE_VERSION=v2025.6.0

# Install system packages
# -----------------------------------------------------------------------------------------
RUN : \
    && apt-get update \
    && apt-get install -y -q --no-install-recommends \
	    ca-certificates \
        curl \
		unzip \
		xz-utils \
		openjdk-21-jdk \
        git \
		git-lfs \
        make \
    && rm -rf /var/lib/apt/lists/* \
    && :
	
ADD https://www.silabs.com/documents/login/software/slc_cli_linux.zip /tmp/slc_cli.zip
RUN : \
    && cd /tmp \
    && unzip -d /opt slc_cli.zip \
	&& :
