FROM python:3.7-alpine

RUN pip3 install Django gunicorn
COPY . /django-sample

CMD [ "/bin/sh", "/django-sample/runguni.sh" ]