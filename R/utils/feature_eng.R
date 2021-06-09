fix_to_numeric = function(handicap,var,verbose=T){
  setnames(handicap,var,"var")
  handicap[,var:=gsub(" ","",var)]
  if(verbose){
    print(unique(handicap[!is.na(var) & is.na(as.numeric(var))][["var"]])) # le champ devrait toujours être numérique et exprimé dans la même unité. Ici on a des mélanges de m² et ha
  }
  handicap[,var:=as.numeric(var)]
  setnames(handicap,"var",var)
  invisible(handicap)
  
}

inplace_recode_features = function(handicap){
  find_mods("Type d'utilisation",handicap)
  handicap[,formation:=grepl("Formation sportive",`Type d'utilisation`)]
  handicap[,performance:=grepl("Performance sportive",`Type d'utilisation`)]
  handicap[,recreation:=grepl("Récréation sportive",`Type d'utilisation`)]
  # handicap[,.N,by=formation]
  # handicap[,.N,by=performance]
  # handicap[,.N,by=recreation]
  find_mods("Types d'aménagements d'information",handicap)
  handicap[,info_chrono:=grepl("Chronométrage fixe",`Types d'aménagements d'information`)]
  handicap[,info_tableau_marque:=grepl("Tableau de marque électronique fixe",`Types d'aménagements d'information`)]
  handicap[,info_sonorisation:=grepl("Sonorisation fixe",`Types d'aménagements d'information`)]
  # handicap[,.N,by=info_chrono]
  # handicap[,.N,by=info_tableau_marque]
  # handicap[,.N,by=info_sonorisation]
  
  
  find_mods("Types de locaux complémentaires",handicap)
  handicap[,buvette:=grepl("Buvette",`Types de locaux complémentaires`)]
  handicap[,salle_cours:=grepl("Salle\\(s\\) de réunion/cours",`Types de locaux complémentaires`)]
  handicap[,reception:=grepl("Reception/accueil",`Types de locaux complémentaires`)]
  handicap[,infirmerie:=grepl("Infirmierie",`Types de locaux complémentaires`)]
  handicap[,centre_medicosportif:=grepl("Centre médico-sportif",`Types de locaux complémentaires`)]
  
  handicap[,.N,by=buvette]
  handicap[,.N,by=salle_cours]
  handicap[,.N,by=reception]
  handicap[,.N,by=infirmerie]
  handicap[,.N,by=centre_medicosportif]
  
  
  find_mods("Accessibilité de l'installation en transport en commun des différents mode",handicap)
  handicap[,access_bus:=grepl("Bus",`Accessibilité de l'installation en transport en commun des différents mode`)]
  handicap[,access_metro:=grepl("Métro",`Accessibilité de l'installation en transport en commun des différents mode`)]
  handicap[,access_tramway:=grepl("Tramway",`Accessibilité de l'installation en transport en commun des différents mode`)]
  handicap[,access_train:=grepl("Train",`Accessibilité de l'installation en transport en commun des différents mode`)]
  handicap[,access_bateau:=grepl("Bateau",`Accessibilité de l'installation en transport en commun des différents mode`)]
  
  find_mods("Type de particularité de l'installation",handicap)
  handicap[,etab_scolaire:=grepl("scolaire",`Type de particularité de l'installation`)]
  handicap[,etab_militaire:=grepl("militaire",`Type de particularité de l'installation`)]
  handicap[,etab_prison:=grepl("pénitentiaire",`Type de particularité de l'installation`)]
  
  
  handicap[,travaux_mise_en_conformite:=grepl("Mise en conformité",`Motifs des derniers gros travaux`)]
  handicap[,.N,by=travaux_mise_en_conformite]
  
  handicap[,taille_erp := factor(`catégorie ERP de l'établissement`)]
  
  fix_to_numeric(handicap,"Emprise foncière de l'installation")
  fix_to_numeric(handicap,"Surface de l'aire d'évolution")
  fix_to_numeric(handicap,"Débit horaire maximal")
  fix_to_numeric(handicap,"Hauteur de l'aire d'évolution")
  fix_to_numeric(handicap,"Largeur de l'aire d'évolution")
  
  handicap[,`Période de mise en service`:=gsub(" ","",`Période de mise en service`)]#on a à la fois 1945-1964 & 1945 - 1964
  
  
  invisible(handicap)
}


