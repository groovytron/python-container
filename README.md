# Docker container for Python web development

[![Build Status](https://travis-ci.org/groovytron/python-container.svg?branch=master)](https://travis-ci.org/groovytron/python-container)

Docker container allowing you to build and test your Python project. _This container mainly targets Python web project developments but you can try to make it work with your project even if your project is not using web technologies_.

## Softwares embedded in the container

The following tools are embedded in the container:

- Python: _3.6.7_
- [Pipenv](https://github.com/pypa/pipenv): _2018.11.26_

## Use the container

We recommend you use the `dev` user instead of `root` when running that container.

The container's working directory is `/var/www/app` so we advise you to mount your project directory onto this place. Building the project interactively in the container

To run the container and open a bash in your python project run the following command:

`docker run -it --entrypoint /bin/bash --user=dev --volume=<path-to-your-python-project-directory>:/var/www/app groovytron/python:latest`

### Commands configurations

- The python interpreter is usable through the `python` or `python3` command
- You can install python packages using either `pip` or `pip3`
- `pipenv` is installed in the container if you want to manage your dependencies using that tool

**Note that as the `PIPENV_VENV_IN_PROJECT` environment variable is set, `pipenv` will create the virtual environment in a folder called `.venv` in your project directory.**
