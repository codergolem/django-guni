#!/bin/sh

set -e

task_build_and_push() {

  echo ${GCP_PROJECT_KEY} | base64 --decode --ignore-garbage > $HOME/gcloud-service-key.json
  export GOOGLE_CLOUD_KEYS="$(cat $HOME/gcloud-service-key.json)"
  export IMAGE_NAME="django-guni"
  export TAG="1"
  task_install
  docker build -t us.gcr.io/$GOOGLE_PROJECT_ID/$IMAGE_NAME -t us.gcr.io/$GOOGLE_PROJECT_ID/$IMAGE_NAME:$TAG .
  docker push us.gcr.io/$GOOGLE_PROJECT_ID/$IMAGE_NAME:$TAG
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