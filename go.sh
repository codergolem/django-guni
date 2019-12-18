#!/bin/sh

set -e

task_build_and_push() {
    docker build . -t django-guni
    docker tag django-guni mariocastellanos/django-guni:2
    docker push mariocastellanos/django-guni:2
}

task_test() {
    cd mariopage
    python manage.py test
}

task_install() {
     pip3 install --user -r requirements.txt
}

main() {
  local task=$1

  if type "task_${task}" &> /dev/null; then
    "task_${task}"
  else
    echo "task ${task} not found"
  fi
}

main "$@"