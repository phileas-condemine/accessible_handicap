library(data.table)

handicap = fread("data/data-es.csv",encoding = "UTF-8")


nm = names(handicap)

grep("access",nm,value=T,ignore.case = T)
grep("handicap",nm,value=T,ignore.case = T)
grep("pratique",nm,value=T,ignore.case = T)

handicap[,.N,by="Statut de la fiche d'enquête"]#cste = TRUE
handicap[,.N,by="Etat de la fiche d'enquête"]#toutes les lignes ne sont pas validées, on l'assume faute de temps pour DQA. On pourrait vérifier les biais avec une classification de cette variable.
handicap[,.N,by="Installation gardiennée"]#T/F/NA
handicap[,.N,by="Installation gardiennée avec logement de gardien sur place"]#T/F/NA
handicap[,.N,by="Nombre d'équipements rattachés à l'installation"]#Grâce à cette variable on apprend/déduit que plusieurs lignes désignent les différentes installations d'un même complexe

handicap[,.N,by="Accessibilité de l'installation en transport en commun"]#T/F/NA
handicap[,.N,by="Installation particulière"]#T/F/NA
handicap[,.N,by="Emprise foncière de l'installation"]#AKA surface du terrain
handicap[,.N,by="Installation gardiennée"]#T/F/NA
handicap[,.N,by="Accessibilité de l'installation en fonction du type handicap"]#distinction handicap moteur ou sensoriel
handicap[,.N,by="Accessibilité partielle ou totale aux personnes en situation de handicap sensoriel"]#T/F/NA
handicap[,.N,by="Etat de la fiche 2"]#T/F/NA
handicap[,.N,by="Type de particularité de l'installation"]# IMPORTANT permet d'identifier les etablissements scolaires, militaires, pénitentiaires !
handicap[,.N,by="Type de l'enquête"]#Téléphone vs vis-à-vis => biais possible ? sur la qualité de l'enquête par exemple.
handicap[,.N,by= "Etat de la fiche d'enquête de l'équipement sportif"]#nouveau, validé, en cours de modif
handicap[,.N,by="Etat de la fiche 1"]#T/F/NA
handicap[,.N,by="Aménagements d'information"]#T/F/NA
handicap[,.N,by= "Arrêté d'ouverture au public"]#T/F/NA
handicap[,.N,by= "Derniers gros travaux réalisés"]#T/F/NA
handicap[,.N,by= "Gestion en DSP"]#T/F/NA
handicap[,.N,by= "Atlas"]#Grande classification en 8 groupes
handicap[,.N,by= "Type d'utilisation"]#récodé (problème d'ordre sur 3 modalités) Récréation, performance ou formation sportive
handicap[,.N,by= "catégorie ERP de l'établissement"]# très intéressant : effet taille de l'établissement #1 à 5 1500+,701-1500, 301-700,300- ou <seuil min fixé par le règlement de sécurité
handicap[,.N,by= "Types d'aménagements d'information"]# Chronométrage, Sonorisation, Tableau de marque, mal codé avec des permutations etc.
handicap[,.N,by= "Types d'aménagements de confort"]# Bains bouillonnants, Sauna, Solarium, Hammam, Autre
handicap[,.N,by= "Type d'ERP de l'établissement"]# https://bpifrance-creation.fr/encyclopedie/locaux-lentreprise/etablissements-recevant-du-public/classification-etablissements
handicap[,.N,by= "Types de locaux complémentaires"]# 10 modalités mélangées : faire une fonction pour recoder ça : OK find_mods
handicap[,.N,by= "Motifs des derniers gros travaux"]
handicap[,.N,by= "Fonction de la personne ressource"]
handicap[,.N,by= "Nature du sol"]
handicap[,.N,by= "Nature de l'équipement sportif"]
handicap[,.N,by= "Type de déclaration"]
handicap[,.N,by= "Période de mise en service"]#tranches de 10 ans
handicap[,.N,by= "Type de propriétaire"]
handicap[,.N,by= "Type de gestionnaire"]
handicap[,.N,by= "Situation de l'équipement espace ou site"]
handicap[,.N,by= "Forme du bassin"]
handicap[,.N,by= "Inscription de l'équipement suite à une déclaration"]
handicap[,.N,by= "Accessibilité juridique"]
handicap[,.N,by= "Equipement inscrit au PDESI / PDIPR"]#T/F/NA info sur les sites de randonnée & itinéraires : sport nature, ski, act aérienne, aquatique, nautique, cyclisme, mécanique ou équeste.
handicap[,.N,by= "Atlas"]

one_var = "Types de locaux complémentaires"

find_mods = function(one_var,data=handicap){
  vec = unique(data[[one_var]])
  vec = gsub("(^\\{)|(\\}$)","",vec)
  vec = strsplit(vec,",")
  vec = unique(unlist(vec))
  vec = gsub('"','',vec)
  vec
}

find_mods("Motifs des derniers gros travaux")


fast_stat_na = function(one_var,data=handicap){
  dt = data[,c("Famille d'équipement sportif",one_var),with=F]
  setnames(dt,one_var,"one_var")
  stat_na = dt[,.(N=.N,
                        not_na = mean(!is.na(one_var))),
                     by="Famille d'équipement sportif"]
  setorder(stat_na,-not_na)
  stat_na
}
fast_stat_na("Rivière de steeple")
fast_stat_na("Débit horaire maximal")
fast_stat_na("Niveau de difficulté le plus élevé")
fast_stat_na("Types d'aménagements de confort")
fast_stat_na("Equipement inscrit au PDESI / PDIPR")
fast_stat_na("Types d'aménagements de confort")
fast_stat_na("Types d'aménagements de confort")
