#!/bin/bash

PROJECT_NAME=testsite

pipenv install django || exit 1
echo 'Creating test django project...'
pipenv run django-admin startproject "$PROJECT_NAME" || exit 1
echo 'Django project created.'
