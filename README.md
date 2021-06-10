# Cas d'étude autour de l'accessibilité du sport pour les personnes handicapées

"Accès au sport pour les personnes en situation de handicap : est-il toujours respecté ?"

## Source des données 

https://data.opendatasoft.com/explore/dataset/data-es%40equipements-sgsocialgouv/export%20/?flg=fr

## Temps passé sur le projet

04/06 : 15 minutes pour lire l'énoncé, créer le projet R et lancer le téléchargement des données
05/06 : 1h30 début du rapport avec qqstats desc sur les indicateurs d'accessibilité/handicap
06/06 : 2h30 revue de littérature rapide, identification de 2 typologies : handicap moteur vs sensoriel & sport pratique vs spectacle (aire de jeu vs tribune). Corrélation entre les critères d'accessibilité.
07/06 : 2h30 fin de revue des variables et catégorisation + recodage partiel. Liste handisports => de nombreux sports pertinents tous handicaps (mais aménagements +/- lourds).
09/06 : 1h ajout liblinear & glmnet::makeX pour OHE les variables
10/06 : 2h ajout GLM avec sélection par modalité 73.4%, GBM 74.1%, Shapley, XGBoost 77.5%, XGBExplainer pour comprendre les plus grosses erreurs ie best-in-class & worst-in-class. 
10/06 : 2h app Shiny de localisation des établissements.

TODO : 
- documenter les fonctions avec roxygen
- ajouter des indicateurs géographiques communaux : revenu, ZUS, ruralité, densité de population, météo (adaptations des espaces ouverts/intérieurs)
- tSNE pour clustering visuel des établissements et interprétation ? Difficile parce que données catégorielles principalement. ACM + t-SNE ?
