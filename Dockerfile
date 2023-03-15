ARG DOTNET_VERSION="3.1.413"
ARG UBUNTU_RELEASE="focal"

FROM ubuntu:${UBUNTU_RELEASE}

ARG DEBIAN_FRONTEND=noninteractive
ARG MIRROR="http://archive.ubuntu.com"

# UBUNTU_RELEASE must be redeclared because it is used before "FROM"
# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG UBUNTU_RELEASE="focal"
ARG UBUNTU_VERSION="20.04"
ARG TARGETPLATFORM
ARG PKGS="\
apt-transport-https \
apt-utils \
build-essential \
ca-certificates \
curl \
git \
gnupg \
gpg \
jq \
libffi-dev \
libssl-dev \
python3-dev \
python3-pip \
python3-virtualenv \
shellcheck \
snapd \
software-properties-common \
tree \
unzip \
zip \
"

# Env vars
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

# Apt Updates
RUN apt update && \
    apt install --no-install-recommends -y ${PKGS} && \
    apt upgrade -y && \
    apt autoremove --purge -y

# packages.microsoft.com repo key
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Microsoft hosted agent uses a User `vsts` with UID `1001` and GID `117`
# https://github.com/microsoft/azure-pipelines-agent/issues/2043#issuecomment-524683461
ARG USER_ID="1001"
RUN adduser --disabled-password --gecos "" --shell /bin/bash --uid ${USER_ID} ubuntu

# hadolint
ARG HADOLINT_VERSION="v2.10.0"
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=x86_64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm/v8" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=x86_64; fi && \
    curl -Lo /usr/local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-${ARCHITECTURE} && \
    chmod +x /usr/local/bin/hadolint

# tfenv
COPY --chown=ubuntu ./.terraform-version /opt/.terraform-version
RUN git clone --depth 1 https://github.com/tfutils/tfenv.git /opt/tfenv && \
    ln -s /opt/tfenv/bin/tfenv /usr/local/bin && \
    ln -s /opt/tfenv/bin/terraform /usr/local/bin && \
    mkdir -p /opt/tfenv/versions && \
    cd /opt && \
    tfenv install && \
    chown -R ubuntu:root /opt/tfenv

# tgenv
COPY --chown=ubuntu ./.terragrunt-version /opt/.terragrunt-version
RUN git clone --depth 1 https://github.com/cunymatthieu/tgenv.git /opt/tgenv && \
    ln -s /opt/tgenv/bin/tgenv /usr/local/bin && \
    ln -s /opt/tgenv/bin/terragrunt /usr/local/bin && \
    mkdir -p /opt/tgenv/versions && \
    cd /opt/tgenv && \
    if [ "$TARGETPLATFORM" = "linux/amd64" ]; then TGENV_ARCH=amd64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then TGENV_ARCH=arm64; elif [ "$TARGETPLATFORM" = "linux/arm64/v8" ]; then TGENV_ARCH=arm64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then TGENV_ARCH=arm64; else TGENV_ARCH=amd64; fi && \
    TGENV_ARCH=${TGENV_ARCH} tgenv install && \
    chown -R ubuntu:root /opt/tgenv

# tfsec
ARG TFSEC_VERSION="0.58.14"
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm/v8" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=amd64; fi && \
    curl -Lo /usr/local/bin/tfsec https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-${ARCHITECTURE} && \
    chmod +x /usr/local/bin/tfsec

# tflint
ARG TFLINT_VERSION="0.30.0"
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm/v8" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=amd64; fi && \
    curl -Lo /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_${ARCHITECTURE}.zip && \
    unzip /tmp/tflint.zip -d /usr/local/bin && \
    python3 -m pip install --no-cache-dir --quiet yamllint

# tflint azurerm plugin
ARG TFLINT_AZURERM_PLUGIN="0.12.0"
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm/v8" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=amd64; fi && \
    mkdir -p /home/ubuntu/.tflint.d/plugins && \
    chown -R ubuntu:ubuntu /home/ubuntu/.tflint.d && \
    curl -Lo /tmp/tflint-ruleset-azurerm_linux_${ARCHITECTURE}.zip https://github.com/terraform-linters/tflint-ruleset-azurerm/releases/download/v${TFLINT_AZURERM_PLUGIN}/tflint-ruleset-azurerm_linux_${ARCHITECTURE}.zip && \
    unzip /tmp/tflint-ruleset-azurerm_linux_${ARCHITECTURE}.zip -d /home/ubuntu/.tflint.d/plugins

# terraform-docs
ARG TERRAFORM_DOCS_VERSION="0.16.0"
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm/v8" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=amd64; fi && \
    curl -Lo /tmp/terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-${ARCHITECTURE}.tar.gz && \
    cd /tmp && \
    tar -xzf terraform-docs.tar.gz && \
    chmod +x terraform-docs && \
    mv terraform-docs /usr/local/bin/terraform-docs

# # terraform plugin-cache
# RUN mkdir -p /home/ubuntu/.terraform.d/plugin-cache && \
#     chown -R ubuntu:ubuntu /home/ubuntu/.terraform.d

# docker https://github.com/docker/docker-install
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    usermod -aG docker ubuntu

# docker-compose https://docs.docker.com/compose/install/linux/#install-the-plugin-manually
ARG DOCKERCOMPOSE_VERSION="2.11.2"
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=x86_64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=aarch64; elif [ "$TARGETPLATFORM" = "linux/arm/v8" ]; then ARCHITECTURE=aarch64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=aarch64; else ARCHITECTURE=x86_64; fi && \
    curl -Lo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/v${DOCKERCOMPOSE_VERSION}/docker-compose-linux-${ARCHITECTURE} && \
    chmod +x /usr/local/bin/docker-compose

# cleanup
RUN apt autoremove --purge -y && \
    find /opt /usr/lib -name __pycache__ -print0 | xargs --null rm -rf && \
    rm -rf /var/lib/apt/lists/*

# COPY --chown=ubuntu ./ /app
# RUN rm -rf /app/*

USER ubuntu
ENV PATH="$PATH:/home/ubuntu/.local/bin"

# BUG: Broken pip due to bad openssl pip module
# https://stackoverflow.com/questions/70544278/pip-install-failing-due-to-pyopenssl-openssl-error
# https://serverfault.com/questions/1099606/ansible-openssl-error-with-apt-module
# https://www.reddit.com/r/saltstack/comments/vc7oyb/getting_cryptographydeprecationwarning_python_36/
# https://bitcoden.com/answers/broken-pip-due-to-bad-openssl-module
RUN python3 -m pip install --no-cache-dir --quiet --upgrade --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org cryptography==38.0.0
# https://www.reddit.com/r/saltstack/comments/vc7oyb/getting_cryptographydeprecationwarning_python_36/
# https://bitcoden.com/answers/broken-pip-due-to-bad-openssl-module
RUN python3 -m pip install --no-cache-dir --quiet --upgrade cachecontrol
RUN python3 -m pip install --no-cache-dir --quiet --upgrade pyopenssl

# pre-commit https://pre-commit.com/#install
RUN python3 -m pip install --no-cache-dir --quiet --upgrade --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org git+https://github.com/pre-commit/pre-commit.git@v2.20.0

# azure cli
# BUG: https://github.com/Azure/azure-cli/issues/7368 so installing via pip
RUN python3 -m pip install --no-cache-dir --quiet --upgrade azure-cli

# cookie-cutter https://github.com/cookiecutter/cookiecutter/blob/master/docs/installation.rst
RUN python3 -m pip install --no-cache-dir --quiet --upgrade cookiecutter

WORKDIR /app
