"""
WSGI config for mariopage project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/howto/deployment/wsgi/
"""

import os
import sys

sys.path.append('/home/mario/dev/pythonHacks/django-sample/myenv/lib/python3.6/site-packages')
from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mariopage.settings')

application = get_wsgi_application()
