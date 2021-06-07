
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
  
  handicap[,travaux_mise_en_conformite:=grepl("Mise en conformité",`Motifs des derniers gros travaux`)]
  handicap[,.N,by=travaux_mise_en_conformite]
  
  handicap[,taille_erp := factor(`catégorie ERP de l'établissement`)]
  invisible(handicap)
}