# Python container (Docker container for Python web development)

[![Build Status](https://travis-ci.org/groovytron/python-container.svg?branch=master)](https://travis-ci.org/groovytron/python-container)

Docker container allowing you to build and test your Python project. _This container mainly targets Python web project developments but you can try to make it work with your project even if your project is not using web technologies_.


## Supported tags and respective `Dockerfile` links

- `3.7` ([3.7/Dockerfile](https://github.com/groovytron/python-container/blob/master/3.7/Dockerfile))
- `3.6` ([3.6/Dockerfile](https://github.com/groovytron/python-container/blob/master/3.6/Dockerfile))

[`pipenv`](https://github.com/pypa/pipenv) is installed in every image to make Python dependencies installation easier.

## Use the container

We recommend you use the `dev` user instead of `root` when running that container.

The container's working directory is `/var/www/app` so we advise you to mount your project directory onto this place.

### Building the project interactively in the container

To run the container and open a bash in your python project run the following command:

`docker run -it --entrypoint /bin/bash --user=dev --volume=<path-to-your-python-project-directory>:/var/www/app groovytron/python:latest`

### Commands configurations

- The python interpreter is usable through the `python` or `python3`
- You can install python packages using either `pip` or `pip3`
- `pipenv` is installed in the container if you want to manage your dependencies using that tool

**Note that as the `PIPENV_VENV_IN_PROJECT` environment variable is set, `pipenv` will create the virtual environment in a folder called `.venv` in your project directory.**

## Contributing

Pull requests, bug reports, and feature requests are welcome.

### Develop locally

If you want to improve one of these images, your will need the following software installed on your system:

- `docker`
- `docker-compose` (if you want to build images using the file [build.yml](https://github.com/groovytron/python-container/blob/master/build.yml))
- `make` (if you want to build images using the file [build.yml](https://github.com/groovytron/python-container/blob/master/build.yml) and abstract from it with the [Makefile](https://github.com/groovytron/python-container/blob/master/Makefile))

Once you have the above softwares installed, run `make python3.7` to build the `python3.7` image.
To build all the images, run `make all`.
If you want to clean your builds, simply run `make clean`.

## License

MIT License. See the LICENSE file.
