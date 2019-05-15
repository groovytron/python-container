#!/bin/bash

PROJECT_NAME=testsite

python --version
python3 --version
pip --version
pip3 --version
pipenv --version

pipenv install django || exit 1
echo 'Creating test django project...'
pipenv run django-admin startproject "$PROJECT_NAME" || exit 1
echo 'Django project created.'
