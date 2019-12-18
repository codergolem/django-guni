#!/bin/sh

set -e
set -o pipefail

function task_build_and_push() {
    docker build . -t django-guni
    docker tag django-guni mariocastellanos/django-guni:2
    docker push mariocastellanos/django-guni:2
}

function test() {
    python3 -m pytest
}

function main() {
  local task=$1

  if type "task_${task}" &> /dev/null; then
    "task_${task}"
  else
    echo "task ${task} not found"
  fi
}

main "$@"