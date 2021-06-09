# Cas d'étude autour de l'accessibilité du sport pour les personnes handicapées

"Accès au sport pour les personnes en situation de handicap : est-il toujours respecté ?"

## Source des données 

https://data.opendatasoft.com/explore/dataset/data-es%40equipements-sgsocialgouv/export%20/?flg=fr

## Temps passé sur le projet

04/06 : 15 minutes pour lire l'énoncé, créer le projet R et lancer le téléchargement des données
05/06 : 1h30 début du rapport avec qqstats desc sur les indicateurs d'accessibilité/handicap
06/06 : 2h30 revue de littérature rapide, identification de 2 typologies : handicap moteur vs sensoriel & sport pratique vs spectacle (aire de jeu vs tribune). Corrélation entre les critères d'accessibilité.
07/06 : 2h30 fin de revue des variables et catégorisation + recodage partiel. Liste handisports => de nombreux sports pertinents tous handicaps (mais aménagements +/- lourds).
09/06 : 

TODO : 
- slide "piège" au début avec les travers du ML ? faire un gbm ou CARET model de OK_H[MS]_JEU
- continuer persona si le temps
- identifier les variables catégorielles OHE
- Simplifier les variables catégorielles ? Privé/public.
- prouver la causalité HM => HS (on a bien !HS => !HM)
- ajouter des indicateurs géographiques communaux : revenu, ZUS, ruralité, densité de population, météo (adaptations des espaces ouverts/intérieurs)
- modèle explicatif de l'accessibilité pour 
   - identifier les facteurs qui expliquent une plus faible accessibilité de certains etablissements
   - proposer un score qui permet de d'identifier les établissements non accessibles qui "devraient" l'être et réciproquement ceux qui "montrent l'exemple" dans un domaine peu accessible
- tSNE pour clustering visuel des établissements et interprétation
