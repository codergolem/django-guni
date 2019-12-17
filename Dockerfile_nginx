FROM nginx:alpine

RUN apk update & apk add python3 python3-dev build-base linux-headers pcre-dev curl
RUN pip3 install Django uwsgi
COPY . /django-sample
RUN mkdir -p /run/uwsgi & mkdir -p /var/log/uwsgi & mkdir /etc/nginx/sites-enabled
RUN cp django-sample/nginx.conf /etc/nginx/nginx.conf 
RUN cp django-sample/django.conf /etc/nginx/conf.d/default.conf
CMD ["/bin/sh", "/django-sample/run.sh"]