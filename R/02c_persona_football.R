library(data.table)
library(plotly)
library(dplyr)
library(rpart)
library(visNetwork) 
library(sparkline)

source("R/utils/custom_funs.R",local = T,encoding = "UTF-8")
source("R/utils/feature_eng.R",local = T,encoding = "UTF-8")
source("R/utils/vars_categ_manuelle.R",local = T,encoding = "UTF-8")
handicap = fread("data/data-es.csv",encoding = "UTF-8")
inplace_recode_features(handicap)

setnames(handicap,c("Accessibilité aux personnes à mobilité réduite à l'aire de jeu",
                    "Accessibilité aux personnes en situation de handicap sensoriel à l'aire de jeu"),
         c("OK_PRATIQUE_HM","OK_PRATIQUE_HS"))


#### ATHLETISME ####
acces_foot = handicap[`Type d'équipement sportif` == "Terrain de football",
                       c(a_tester,a_tester_recodee,specifique_stade,"OK_PRATIQUE_HM","OK_PRATIQUE_HS"),with=F]



##### HANDICAP MOTEUR #####

##### TREE ##### 
model <- rpart(OK_PRATIQUE_HM~.,data=acces_foot,
               control = rpart.control(cp = 0.002))
g <- visTree(model)
g 
# htmlwidgets::saveWidget(g,selfcontained = T,file="athle_hm_effet_type_equip_nature_sol.html")
model <- rpart(OK_PRATIQUE_HM~.,data=acces_foot[,-c("Type de l'enquête","Présence de sanitaires")],
               control = rpart.control(cp = 0.002))
g <- visTree(model)
g



##### GLM ##### 

coeffs = two_step_glm(acces_foot,"OK_PRATIQUE_HM")
coeffs[order(Estimate,decreasing = T)]
saveRDS(coeffs,"data/football_effet_annee_construction_OK_PRATIQUE_HM.rds")
ax <- list(title = "", showticklabels = FALSE, showgrid = FALSE)
plot_margin(coeffs = coeffs,pattern = "^Periode_de_mise_en_service",.01)%>%layout(xaxis=ax)

##### HANDICAP SENSORIEL #####

##### TREE ##### 

model <- rpart(OK_PRATIQUE_HS~.,data=acces_foot)
g <- visTree(model)
g # !access HM => !access HS
# htmlwidgets::saveWidget(g,selfcontained = T,file="athle_hm_effet_okHM_et_parking_handicap.html")

model <- rpart(OK_PRATIQUE_HS~.,data=acces_foot[,-c("OK_PRATIQUE_HM","Dont nombre de place de parking réservées aux personnes en situation de handicap")],
               control = rpart.control(cp = 0.001))
g <- visTree(model)
g# Les plus grands stades : immenses, accessibles HM & dans les plus grandes villes (métro) sont aussi accessibles HS... facile, non ?


coeffs = two_step_glm(acces_foot,"OK_PRATIQUE_HS")
coeffs[order(Estimate,decreasing = T)]
#Nature du sol = Métal ALORS QU'IL Y A JUSTE 1 OBSERVATION !!??

