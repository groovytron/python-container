#!/bin/bash

python --version
python3 --version
pip --version
pip3 --version
poetry --version

# PROJECT_NAME=testsite
# POETRY_PROJECT_DIR=test_poetry
# 
# # Create repository folders
# mkdir -p "$POETRY_PROJECT_DIR"
# 
# # Poetry test
# cd "$POETRY_PROJECT_DIR" || exit 1
# 
# poetry init --no-interaction
# 
# poetry add Django || exit 1
# echo 'Creating test django project using poetry...'
# 
# poetry run django-admin startproject "$PROJECT_NAME" || exit 1
# echo 'Django project created with poetry.'
