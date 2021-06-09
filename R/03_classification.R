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

handicap[,famille_effectif := .N,by="Famille d'équipement sportif"]
handicap$id = 1:nrow(handicap)

train_ids = sample(handicap$id,size = 1E+5,prob = 1/handicap$famille_effectif)

train = handicap[id%in%train_ids,c(a_tester,a_tester_recodee,"OK_PRATIQUE_HM","OK_PRATIQUE_HS")]
train[,.N,by="Famille d'équipement sportif"]

##### HANDICAP MOTEUR #####

##### TREE ##### 
model <- rpart(OK_PRATIQUE_HM~.,data=train,
               control = rpart.control(cp = 0.01))
g <- visTree(model)
g 
# htmlwidgets::saveWidget(g,selfcontained = T,file="athle_hm_effet_type_equip_nature_sol.html")
model <- rpart(OK_PRATIQUE_HM~.,data=train[,-c("Type de l'enquête","Présence de sanitaires")],
               control = rpart.control(cp = 0.005))
g <- visTree(model)
g



##### GLM ##### 

coeffs = two_step_glm(handicap,"OK_PRATIQUE_HM")
coeffs[order(Estimate,decreasing = T)]