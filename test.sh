#!/bin/bash

PROJECT_NAME=testsite

pipenv install django
echo 'Creating test django project...'
pipenv run django-admin startproject "$PROJECT_NAME"
echo 'Django project created.'
