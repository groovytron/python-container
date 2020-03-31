#!/bin/bash

PROJECT_NAME=testsite
PIPENV_PROJECT_DIR=test_pipenv
POETRY_PROJECT_DIR=test_poetry

python --version
python3 --version
pip --version
pip3 --version
pipenv --version
poetry --version

# Create repository folders
mkdir -p "$PIPENV_PROJECT_DIR" "$POETRY_PROJECT_DIR"

# Pipenv test
cd "$PIPENV_PROJECT_DIR"

pipenv install django || exit 1
echo 'Creating test django project with pipenv...'

pipenv run django-admin startproject "$PROJECT_NAME" || exit 1
echo 'Django project created with pipenv.'

# Poetry test
cd "../$POETRY_PROJECT_DIR"

poetry init --no-interaction

poetry add Django || exit 1
echo 'Creating test django project using poetry...'

poetry run django-admin startproject "$PROJECT_NAME" || exit 1
echo 'Django project created with poetry.'
