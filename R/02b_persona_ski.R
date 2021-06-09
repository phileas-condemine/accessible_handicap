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


#### SKI ####
acces_ski = handicap[`Famille d'équipement sportif` == "Equipement & piste de ski",
                       c(a_tester,a_tester_recodee,specifique_athletisme,"OK_PRATIQUE_HM","OK_PRATIQUE_HS"),with=F]

model <- rpart(OK_PRATIQUE_HM~.,data=acces_ski)
g <- visTree(model)
g 

coeffs = two_step_glm(acces_ski,"OK_PRATIQUE_HM")
saveRDS(coeffs,"data/ski_effet_annee_construction_OK_PRATIQUE_HM.rds")
ax <- list(title = "", showticklabels = FALSE, showgrid = FALSE)
plot_margin(coeffs = coeffs,pattern = "^Periode_de_mise_en_service",.01)%>%layout(xaxis=ax)


model <- rpart(OK_PRATIQUE_HS~.,data=acces_ski)
g <- visTree(model)
g # l
# htmlwidgets::saveWidget(g,selfcontained = T,file="athle_hm_effet_okHM_et_parking_handicap.html")




