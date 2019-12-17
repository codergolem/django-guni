#!/bin/sh
cd /django-sample/mariopage
gunicorn --config ../gunicorn_conf.py mariopage.wsgi