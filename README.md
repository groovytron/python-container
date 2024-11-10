# Python container (Docker container for Python web development)

[![Build Status](https://github.com/groovytron/python-container/actions/workflows/ci.yml/badge.svg)](https://github.com/groovytron/python-container/actions/workflows/ci.yml)

Docker container allowing you to build and test your Python project. _This container mainly targets Python web project developments but you can try to make it work with your project even if your project is not using web technologies_.

## Supported tags and respective `Dockerfile` links

- `3.12`, `latest` ([3.12/Dockerfile](https://github.com/groovytron/python-container/blob/master/3.12/Dockerfile))
- `3.8` ([3.8/Dockerfile](https://github.com/groovytron/python-container/blob/master/3.8/Dockerfile))
- `3.7` ([3.7/Dockerfile](https://github.com/groovytron/python-container/blob/master/3.7/Dockerfile))
- `3.6` ([3.6/Dockerfile](https://github.com/groovytron/python-container/blob/master/3.6/Dockerfile))

[`poetry`](https://python-poetry.org/) is installed in every image to make Python dependencies installation easier.

The following dependencies are installed to make wheel installation work properly:

- [build-essentials](https://packages.ubuntu.com/bionic/build-essential) (`g++`, `gcc`, `make` and `libc6-dev`)
- [python-dev](https://packages.ubuntu.com/bionic-updates/python3.8-dev) (header files and static library for Python)

## Use the container

We recommend you to use the `dev` user instead of `root` when running that container.

The container's working directory is `/var/www/app` so we advise you to mount your project directory onto this place.

### Building the project interactively in the container

To run the container and open a bash in your python project run the following command:

`docker run -it --entrypoint /bin/bash --user=dev --volume=<path-to-your-python-project-directory>:/var/www/app groovytron/python:latest`

### Commands configurations

- The python interpreter is usable through the `python` or `python3`
- You can install python packages using either `pip` or `pip3`
- You can manage your dependencies using either `poetry` or `pipenv`

**Note**: as the `PIPENV_VENV_IN_PROJECT` environment variable is set, `pipenv` will create the virtual environment in a folder called `.venv` in your project directory. This configuration is applied to `root` and `dev` users.

**Note**: as poetry's configuration is contained into [config/poetry/config.toml](https://github.com/groovytron/python-container/blob/master/config/poetry/config.toml) and [`virtualenvs.in-project`](https://python-poetry.org/docs/configuration/#virtualenvsin-project-boolean) is set to `true`, `poetry` will create the virtual environment in a folder called `.venv` in your project directory. This configuration is applied to `root` and `dev` users.

## Contributing

Pull requests, bug reports, and feature requests are welcome.

### Develop locally

If you want to improve one of these images, you will need the following software installed on your system:

- `docker`
- `docker-compose` (if you want to build images using the file [build.yml](https://github.com/groovytron/python-container/blob/master/build.yml))
- `make` (if you want to build images using the file [build.yml](https://github.com/groovytron/python-container/blob/master/build.yml) and abstract from it with the [Makefile](https://github.com/groovytron/python-container/blob/master/Makefile))

Once you have the above softwares installed, run `make python3.7` to build the `python3.7` image. To build all the images, run `make all`. If you want to clean your builds, simply run `make clean`.

## License

MIT License. See the LICENSE file.
