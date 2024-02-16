#!/bin/bash

# Création des variables
export PROJET=tp-log-411012 # Change me
export BUCKET=tp-log # Change me
export REGION=us-central1 # Change me
export ZONE=us-central1-c # Change me
export CLUSTER=cluster-1 # Change me
export SA=812099386875@cloudbuild.gserviceaccount.com # Change me (cloudbuild api doit être activé)

# 1- Connexion au cluster
gcloud container clusters get-credentials $CLUSTER --region $ZONE --project $PROJET
# gcloud container clusters get-credentials cluster-1 --region us-central1-c --project tp5-log

# 2- Add IAM policy
gcloud projects add-iam-policy-binding $PROJET --member=serviceAccount:$SA --role=roles/container.developer

# 3- Creation cluster role binding
kubectl create clusterrolebinding sa-cluster-admin-binding --clusterrole=cluster-admin --user=$SA

# 4- Creation des ressources Elastic
kubectl create -f https://download.elastic.co/downloads/eck/2.10.0/crds.yaml

# 4- Installation de l'operateur
kubectl apply -f https://download.elastic.co/downloads/eck/2.10.0/operator.yaml

# 5- Attente du déploiement de l'operator
sleep 60

# 6- Deploiement avec l'outils CloudBuild de GCP
gcloud builds submit --region=$REGION --project=$PROJET --config ./fleet/cloudbuild.yml --gcs-log-dir="gs://$BUCKET/elastic"
