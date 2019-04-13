FROM ubuntu:bionic

ARG PIPENV_VERSION

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHON_BIN=/usr/bin/python
ENV PIP_BIN=/usr/bin/pip
ENV PIPENV_VENV_IN_PROJECT=yes

RUN apt-get update \
    && apt-get upgrade --quiet --yes \
    && apt-get install software-properties-common --yes --quiet \
    && apt-get update --quiet \
    && apt-get install --quiet --yes \
        locales \
        python3-pip \
        tzdata \
        unzip \
    && apt-get autoremove --quiet --yes \
    && apt-get clean \
    && pip3 install pipenv

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
RUN ln -sf $(which python3) ${PYTHON_BIN}
RUN ln -sf $(which pip3) ${PIP_BIN}

EXPOSE 8000

# Mount your app source code directory into that folder
WORKDIR /var/www/app

# Create less privileged user
RUN groupadd --gid 1000 dev \
  && useradd --uid 1000 --gid dev --shell /bin/bash --create-home dev

# Fix permissions issues
RUN chmod -R a+wrx /var/www/app
RUN chmod -R a+wrx ${PYTHON_BIN}
RUN chmod -R a+wrx ${PIP_BIN}

# Label schema related variables and metadata
ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Julien M'Poy <julien.mpoy@gmail.com>" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.vcs-ref=${VCS_REF} \
    org.label-schema.vcs-url="https://github.com/groovytron/python-container" \
    org.label-schema.schema-version="1.0"
