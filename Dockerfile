FROM ubuntu:noble
ARG DEBIAN_FRONTEND=noninteractive
# ARG RELEASE_VERSION=v2025.6.0
# ARG SL_STUDIO_BUILD_PATH="/opt/SimplicityStudio"
# ARG ARM_GCC_DIR=toolchains/arm-gnu-toolchain-12.2.rel1-x86_64-arm-none-eabi

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
		python3-pip \
		libgl1 \
	&& rm -rf /var/lib/apt/lists/* \
 	&& :

RUN pip3 install gitpython
 
ADD https://developer.arm.com/-/media/Files/downloads/gnu/12.2.rel1/binrel/arm-gnu-toolchain-12.2.rel1-x86_64-arm-none-eabi.tar.xz /tmp/arm-gnu-toolchain.tar.xz
RUN :\
	&& cd /tmp \
	&& mkdir /opt/gnu_arm \
	&& tar -xf arm-gnu-toolchain.tar.xz --strip 1 -C /opt/gnu_arm \
	&& :

ADD https://www.silabs.com/documents/login/software/slc_cli_linux.zip /tmp/slc_cli.zip
RUN : \
	&& cd /tmp \
	&& unzip -d /opt slc_cli.zip \
	&& :

ADD https://github.com/AEP-CI-TEAM/ci_tools/releases/download/v6.1/commander.zip /tmp/simplicity_commander.zip
RUN : \
	&& cd /tmp \
	&& unzip -d /opt simplicity_commander.zip \
	&& :

ADD https://github.com/project-chip/zap/releases/download/v2025.01.15/zap-linux-x64.zip /tmp/zap-linux-x64.zip
RUN : \
	&& cd /tmp \
	&& unzip -d /opt zap-linux-x64.zip
 	&& :


ENV PATH="$PATH:/opt/slc_cli:/opt/gnu_arm/bin:/opt/zap"

CMD ["/opt/zap/zap-cli", "status"]
