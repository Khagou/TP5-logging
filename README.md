# TP5 Mettre en place une solution de centralisation et de gestion des logs avec la suite Elastic

## Contexte et composition du repot

Il est demande de mettre en place une solution de centralisation et de gestion des logs pour le cluster Kubernetes et les applications qu’il contient.

L'ensemble du repot permet de déployer Elastic Cloud for Kubernetes sur un cluster GKE.
Le repot est composé de 1 dossier:

- Le dossier **fleet** est lui meme compose de :
  - d'un fichier **fleet.yml** qui déploie elastic, kibana, fleet et nginx
  - d'un fichier **cloudbuild.yml** qui permets de lancer le déploiement avec cloudbuild
- Le script **prod.sh** qui ce connecte au cluster, ajoute les droits au compte de service **<numero_de_projet>@cloudbuild.gserviceaccount.com** et lance le deploiement de ECK et Nginx

## Prerequis

- Disposer d'un compte de facturation GCP
- Disposer d'un cluster avec des nodes sur des type de machines e2-standard-2
- Disposer d'un bucket
- Avoir activé l'API cloudbuild



### Deploiement

1- Accéder à Cloud Shell et cloner le repot
2- Ouvrir l'éditeur et modifier l'ensemble des variable du script **prod.sh**
3- DAns le fichier cloudbuild.yml modifier la location et le cluster
4- Ouvrir un terminal dans l'editeur et lancer la commande 
  ```sh prod.sh```
5- Dans la console GCP accéder aux charges de travail de votre cluster et attendez que tout les **Etat** soient vert
6- Lancez maintenant la commande suivatent pour recupérer le mot de passe pour accéder à Kibana
  ```kubectl get secret elasticsearch-quickstart-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo```
7- Dans vos charges de travail ouvrez la suivante ***kibana-quickstart-kb*** et dans la section **Services associés** cliquez sur le point de terminaison, 
   une nouvelle page s'ouvre avec une erreur cette page ne fonctionne pas rajouter https:// au debut de l'url tel que par exemple **https://34.16.25.221:5601/**.
8- Identifiant Kibana
    user: elastic
    mdp: le mot de passe que vous avez recupéré précédemment
