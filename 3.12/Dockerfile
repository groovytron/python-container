FROM docker.io/python:3.12-bookworm

ENV DEV_USER=dev

RUN apt-get update --yes --quiet \
	&& apt-get upgrade --yes --quiet \
	&& apt-get install --yes --quiet \
	build-essential \
        curl \
        git \
        locales \
	pipx \
	tzdata \
        unzip \
	vim \
	&& apt-get autoremove --quiet --yes \
	&& apt-get clean

EXPOSE 8000

# Mount your app source code directory into that folder
WORKDIR /var/www/app

# Create unprivileged dev user
RUN groupadd --gid 1000 ${DEV_USER} \
  && useradd --uid 1000 --gid ${DEV_USER} --shell /bin/bash --create-home ${DEV_USER}

# Fix permissions issues
RUN chmod --recursive a+wrx /var/www/app

# Set the locale
RUN locale-gen en_US \
	&& locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Copy Poetry configuration file
COPY config/poetry/config.toml /root/.config/pypoetry/config.toml
COPY config/poetry/config.toml /home/${DEV_USER}/.config/pypoetry/config.toml
RUN chmod -R 775 /root/.config
RUN chown -R ${DEV_USER}:${DEV_USER} /home/${DEV_USER}/.config && chmod -R 775 /home/${DEV_USER}/.config

USER dev

# Install Poetry
ARG POETRY_VERSION
RUN pipx install poetry=="${POETRY_VERSION}"

ENV PATH="/home/${DEV_USER}/.local/bin:$PATH"

# Label schema related variables and metadata
ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.authors="Julien M'Poy <julien.mpoy@gmail.com>" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.description="Python container for local Python web development" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.revision=${VCS_REF} \
    org.opencontainers.image.source="https://github.com/groovytron/python-container" \
    org.opencontainers.image.title="Python Container" \
    org.opencontainers.image.url="https://github.com/groovytron/python-container" \
    org.opencontainers.image.vendor="Julien M'Poy <julien.mpoy@gmail.com>" \
    org.opencontainers.image.version="3.8"
