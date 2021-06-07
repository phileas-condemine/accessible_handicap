IDs = c(
  "Numéro de l'installation sportive",
  "Nom de l'installation sportive",
  "Numéro de l'équipement sportif",
  "Nom de l'équipement sportif"
)
metadata_survey = c(
  "Statut de la fiche d'enquête",
  "Etat de la fiche d'enquête",
  "Date de création de la fiche d'enquête",
  "Date de changement d'état de la fiche d'enquête",
  "Date de validation de la fiche d'enquête",
  "Date d'enquête"
)
data_perso = c(
  "Nom du bâtiment",
  "Adresse internet de l'équipement",
  "Prénom de la personne ressource",
  "Nom de la personne ressource",
  "Email de la personne ressource",
  "Téléphone de la personne ressource",
  "Nom du propriétaire",
  "Prénom du propriétaire",
  "Adresse du propriétaire",
  "Code postal du propriétaire",
  "Commune de propriétaire",
  "Téléphone du propriétaire",
  "Fax du propriétaire",
  "Courriel du propriétaire",
  "Nom du propriétaire secondaire",
  "Prénom du propriétaire secondaire",
  "Adresse du propriétaire secondaire",
  "Code postal du propriétaire secondaire",
  "Commune de prorpriétaire secondaire",
  "Téléphone du propriétaire secondaire",
  "Fax du propriétaire secondaire",
  "Courriel du popriétaire secondaire",
  "Nom du gestionnaire",
  "Nom du co-gestionnaire",
  "Nom de la personne ayant établi la déclaration",
  "Prénom de la personne ayant établi la déclaration",
  "Courriel de la personne ayant établi la déclaration",
  "Adresse de la personne ayant établi la déclaration",
  "Code postal de la personne ayant établi la déclaration",
  "Commune de la personne ayant établi la déclaration",
  "Commune de rédaction de la déclaration",
  "Fonction de la personne ressource",
  "Civilité de la personne ressource"
)
Geo = c(
  "Numéro, type et nom de la voie",
  "Code postal",
  "Commune",
  "Code insee de la commune",
  "REG",
  "Nom département",
  "DEP",
  "Code2016",
  "CT",
  "Nom Commune",
  "COM",
  "NCC",
  "TNCC",
  "CHEFLIEU",
  "AR",
  "Nom région",
  "coordonnees",
  "Longitude (WGS84)",
  "Latitude (WGS84)"
)
weird = c("Etat de la fiche 2",#booleen
          "Etat de la fiche 1",#booleen
          "Derniers gros travaux réalisés",#booleen
          "ARTMAJ","ARTMIN","CDC","cocode_deptostal"
)
Indic_Access = grep("^access.*(réduite|handicap)",names(handicap),value=T,ignore.case = T)
a_tester = c(
  "Installation gardiennée",
  "Installation gardiennée avec logement de gardien sur place",
  "Possibilité d'hébergement dans l'installation",
  "Installation implantée sur plusieurs communes",
  "Possibilité de restauration dans l'installation",
  "Nombre d'équipements rattachés à l'installation",
  "Nombre de lits de l'installation",
  "Nombre de places de parking réservées à l'installation",
  "Dont nombre de place de parking réservées aux personnes en situation de handicap",
  "Accessibilité de l'installation en transport en commun",
  "Installation particulière",
  "Emprise foncière de l'installation",
  "Type de particularité de l'installation",
  "Accessibilité de l'installation en transport en commun des différents mode",
  "Type de l'enquête",
  "Type d'équipement sportif",
  "Famille d'équipement sportif",
  "Atlas",
  "Etat de la fiche d'enquête de l'équipement sportif",
  "Eclairage de l'aire d'évolution",
  "Equipement d'accès libre",
  "Aménagements d'information",
  "Aménagements de confort",
  "Nombre de vestiaires sportifs",
  "Soumis à la procédure de l'homologation préfectorale",
  "Arrêté d'ouverture au public",
  "Démarche pour la qualité environnementale",
  "Locaux complémentaires",
  "Ouverture exclusivement saisonnière",
  "Présence de douches",
  "Présence de sanitaires",
  "Présence de vestiaires sportifs chauffés",
  "Aire d'évolution chauffée",
  "Gestion en DSP",
  "Présence d'un treuil",
  "Présence de moyen d'alerte",
  "Existence d'une aide publique à l'investissement",
  "Présence de locaux pédagogiques",
  "Présence de locaux techniques",
  "Présence d'une signalétique de sécurité",
  "Hauteur de l'aire d'évolution",
  "Largeur de l'aire d'évolution",
  "Longueur de l'aire d'évolution",
  "Surface de l'aire d'évolution",
  "Nombre de couloirs/pistes/postes/jeux/pas",
  "Nombre de places assises en tribune",
  "Nombre de vestiaires arbitres/enseignants",
  "SAE: nombre de couloirs de la structure",
  "SAE: hauteur maximale de la structure",
  "SAE: surface totale de la structure",
  "Débit horaire maximal",
  "Niveau de difficulté le plus élevé",
  "Niveau de difficulté le plus bas",
  "Nature du sol",
  "Nature de l'équipement sportif",
  "Période de mise en service",
  "Période de l'homologation préfectorale",
  "Période des derniers gros travaux",
  "Type de propriétaire",
  "Type de gestionnaire",
  "Equipement inscrit au PDESI / PDIPR"
)

vars_useless = c(
  "Type de déclaration",
  "Type de propriétaire secondaire",
  "Type du co-gestionnaire",
  "Situation de l'équipement espace ou site", # trop rare
  "Forme du bassin",#rect/carré vs autre 
  "Accessibilité juridique",#T vs NA
  "Inscription de l'équipement suite à une déclaration"
)

a_tester_recodee = c(
  "formation",
  "performance",
  "recreation",
  "info_chrono",
  "info_tableau_marque",
  "info_sonorisation",
  "buvette",
  "salle_cours",
  "reception",
  "infirmerie",
  "centre_medicosportif",
  "travaux_mise_en_conformite"
)


a_recoder = c(  
  "taille_erp",
  "Types de locaux complémentaires",
  "Types d'aménagements de confort",
  "Type d'ERP de l'établissement",
  "Types de chauffage - source d'énergie",
  "Types d'utilisateur",
  "Type de pas de tir",
  "Types d'accès pour le public",
  "Types d'accès pour les secours",
  "Types d'aménagements complémentaires des bassins",
  "Types d'aménagements complémentaires de station de ski"
)

specifique_stade = c("Présence d'une tour d'arrivée (si stade)")
specifique_ski = c(
  "Aménagement complémentaire de station de ski",
  "Altitude la plus basse de la station de ski",
  "Altitude la plus haute de la station de ski",
  "Nombre total de kilomètres de piste de ski alpin",
  "Nombre total de kilomètres de piste de fond/nordique",
  "Nombre total de kilomètres de piste bénificiant d'un enneigement artificiel",
  "Nombre total de remontées mécaniques"
)
specifique_athletisme = c(
  "Longueur de la piste",
  "Longueur de la ligne droite d'arrivée",
  "Nombre de couloirs dans la ligne droite d'arrivée",
  "Nombre de couloirs hors ligne droite",
  "Rivière de steeple",
  "Nombre total d'aires de saut",
  "Nombre d'aires de saut en hauteur",
  "Nombre d'aires de saut en longueur",
  "Nombre d'aires de saut en longueur et triple saut",
  "Nombre d'aires de saut à la perche",
  "Nombre total d'aires de lancer",
  "Nombre d'aires de lancer de poids",
  "Nombre d'aires de lancer de disque",
  "Nombre d'aires de lancer de javelot",
  "Nombre d'aires de lancer de marteau",
  "Nombre d'aires de lancer de mixte disque-marteau"
)
specifique_aquatique = c(
  "Présence d'une pataugeoire",
  "Aménagements complémentaires des bassins",
  "Longueur du bassin",
  "Largeur du bassin",
  "Surface du bassin",
  "Profondeur minimale du bassin",
  "Profondeur maximale du bassin",
  "Nombre de couloirs des bassins mixtes et sportifs",
  "Surface des plages du bassin",
  "Nombre total de tremplins",
  "Nombre de tremplins de 1 mètre",
  "Nombre de tremplins de 3 mètres",
  "Nombre total de plate-formes",
  "Nombre de plate-forme de 3 mètres",
  "Nombre de plate-forme de 5 mètres",
  "Nombre de plate-forme de 10 mètres",
  "Nombre de plate-forme de 7, 5 mètres"
)

dates_a_tester = c(  # garder uniquement l'année et découper en tranches de 5 ans.
  "Date de l'homologation préfectorale",  #déjà regroupé en tranches de 10 ans dans "Période...
  "Date de rédaction de la déclaration",  
  "Date des derniers gros travaux",  #déjà regroupé en tranches de 10 ans dans "Période...
  "Année de mise en service",  #déjà regroupé en tranches de 10 ans dans "Période de mise en service"
  "Date d'enquête"#biais possible si l'enquête est ancienne
)



redondant = c("Code du type d'équipement sportif",
              "Type d'utilisation",#recodé selon les 3 types d'usages possibles séparés,
              "catégorie ERP de l'établissement",#recodé en factor dans taille_erp
              "Types d'aménagements d'information",#recodé 3 modalités possibles chrono, sono, tableau
              "Types de locaux complémentaires", #partiellement recodé
              "Motifs des derniers gros travaux"  #partiellement recodé
)