#!/bin/sh

set -e

GCLOUD_KEY_FILE='gcloud-service-key.json'

authenticate_in_gcloud() {
  echo ${GCP_PROJECT_KEY} | base64 -d | gcloud auth activate-service-account --key-file=-
  gcloud --quiet config set project ${GOOGLE_PROJECT_ID}
  gcloud --quiet config set compute/zone ${GOOGLE_COMPUTE_ZONE}-a
}

install_kubectl() {
  gcloud components install kubectl
}

task_deploy() {
  install_kubectl
  authenticate_in_gcloud
  gcloud container clusters get-credentials gke-sample-cluster
  kubectl apply -f sample-deployment.yaml
  kubectl apply -f sample-service.yaml
}

task_build_and_push() {

  echo ${GCP_PROJECT_KEY} | base64 --decode --ignore-garbage > $HOME/$GCLOUD_KEY_FILE
  export GOOGLE_CLOUD_KEYS="$(cat $HOME/$GCLOUD_KEY_FILE)"
  export IMAGE_NAME="django-guni"
  export TAG="1"
  task_install
  docker build -t us.gcr.io/$GOOGLE_PROJECT_ID/$IMAGE_NAME -t us.gcr.io/$GOOGLE_PROJECT_ID/$IMAGE_NAME:$TAG .
  cat $HOME/$GCLOUD_KEY_FILE | docker login -u _json_key --password-stdin https://us.gcr.io
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