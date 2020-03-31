# vim: set syntax=dockerfile:

FROM ubuntu:bionic

ARG PYTHON_VERSION
ARG PIPENV_VERSION
ARG POETRY_VERSION

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHON_BIN=/usr/bin/python
ENV PIP_BIN=/usr/bin/pip
ENV PIPENV_VENV_IN_PROJECT=yes
ENV DEV_USER=dev

RUN apt-get update \
    && apt-get upgrade --quiet --yes \
    && apt-get update --quiet \
    && apt-get install --quiet --yes \
        curl \
        locales \
        python${PYTHON_VERSION} \
        python3-distutils \
        python${PYTHON_VERSION}-venv \
        software-properties-common \
        tzdata \
        unzip \
    && apt-get autoremove --quiet --yes \
    && apt-get clean \
    && curl --silent https://bootstrap.pypa.io/get-pip.py | python${PYTHON_VERSION} \
    && pip3 install pipenv==${PIPENV_VERSION} poetry==${POETRY_VERSION}

# Set the locale
RUN locale-gen en_US
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Zurich /etc/localtime

# Create symbolic link to Python 3 binaries
RUN ln -sf $(which python${PYTHON_VERSION}) ${PYTHON_BIN}
RUN ln -sf $(which python${PYTHON_VERSION}) ${PYTHON_BIN}3

EXPOSE 8000

# Mount your app source code directory into that folder
WORKDIR /var/www/app

# Create less privileged user
RUN groupadd --gid 1000 ${DEV_USER} \
  && useradd --uid 1000 --gid ${DEV_USER} --shell /bin/bash --create-home ${DEV_USER}

# Fix permissions issues
RUN chmod --recursive a+wrx /var/www/app
RUN chmod a+wrx ${PYTHON_BIN}
RUN chmod a+wrx ${PYTHON_BIN}3

# Copy Poetry configuration file
COPY config/poetry/config.toml /root/.config/pypoetry/config.toml
COPY config/poetry/config.toml /home/${DEV_USER}/.config/pypoetry/config.toml
RUN chmod -R 775 /root/.config
RUN chown -R ${DEV_USER}:${DEV_USER} /home/${DEV_USER}/.config && chmod -R 775 /home/${DEV_USER}/.config

# Label schema related variables and metadata
ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Julien M'Poy <julien.mpoy@gmail.com>" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://github.com/groovytron/python-container" \
    org.label-schema.vcs-ref=${VCS_REF} \
    org.label-schema.vcs-url="https://github.com/groovytron/python-container" \
    org.opencontainers.image.authors="Julien M'Poy <julien.mpoy@gmail.com>" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.description="Python container for local Python web development" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.revision=${VCS_REF} \
    org.opencontainers.image.source="https://github.com/groovytron/python-container" \
    org.opencontainers.image.title="Python Container" \
    org.opencontainers.image.url="https://github.com/groovytron/python-container" \
    org.opencontainers.image.vendor="Julien M'Poy <julien.mpoy@gmail.com>" \
    org.opencontainers.image.version="3.8"
