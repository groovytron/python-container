# Changelog

## 2.0.1

- feature: add `publish` and `tag` targets to `Makefile` to make images publishing easier
- fix: add `build-essentials` and Python header files and static library to improve compatibility with some wheels (eg. [thriftpy2](https://github.com/Thriftpy/thriftpy2) which needs gcc and Python header files)

## 2.0.0

- feature: add image for Python 3.8 (issue #3)
- feature: add poetry to manage dependencies (issue #2)

## 1.0.0

- feature: add images for Python 3.6 and Python 3.7
- feature: pipenv is embedded to manage dependencies
- feature: added [Open Containers Initiative's annotations](https://github.com/opencontainers/image-spec/blob/bd4f8fcb0979a663d8b97a1d4d9b030b3d2ca1fa/annotations.md) to images (issue #1)
