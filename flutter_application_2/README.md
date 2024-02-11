MIAGE COSTA - Application Mobile de Shopping

Introduction
MIAGE COSTA est une application mobile développée avec Flutter, destinée à proposer des activités variées aux utilisateurs. Elle permet de consulter une liste d'activités, de voir le détail d'une activité, d'ajouter des activités à un panier, et de consulter son profil utilisateur. L'application utilise Firebase pour l'authentification des utilisateurs et le stockage des données.

Fonctionnalités
Authentification : Les utilisateurs peuvent se connecter à l'application en utilisant leurs identifiants. Le système d'authentification est géré par Firebase Auth.
Liste d'Activités : Après la connexion, les utilisateurs accèdent à une liste d'activités qu'ils peuvent parcourir. Les activités sont récupérées depuis Cloud Firestore et peuvent être filtrées par catégories.
Détail d'Activité : En cliquant sur une activité, les utilisateurs peuvent voir plus de détails à son sujet, comme une image, le lieu, le prix, et le nombre minimum de participants.
Panier : Les utilisateurs peuvent ajouter des activités à leur panier et consulter ce dernier. Le panier est géré localement et peut être consulté à partir de la barre de navigation inférieure.
Profil Utilisateur : Les utilisateurs peuvent accéder à leur profil pour voir et éditer leurs informations personnelles. Les données du profil sont stockées et récupérées depuis Cloud Firestore.

Architecture
Firebase Auth : Utilisé pour l'authentification des utilisateurs.
Cloud Firestore : Base de données NoSQL utilisée pour stocker les données des activités et les profils utilisateurs.
Flutter : Framework de développement mobile pour construire l'UI et la logique de l'application.

Design
L'application adopte une palette de couleurs luxueuses avec des teintes de violet et de marron pour offrir une expérience utilisateur riche et agréable. Les éléments UI tels que les boutons, les champs de saisie, et les onglets sont stylisés pour correspondre à cette palette de couleurs.

Déploiement
L'application est conçue pour être déployée sur des appareils Android et iOS. Elle requiert Flutter SDK pour le développement et le déploiement, ainsi qu'un projet Firebase configuré avec Auth et Firestore.
