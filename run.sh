#!/bin/sh
uwsgi --ini django-sample/django.ini &
nginx
# curl "http://localhost/polls"