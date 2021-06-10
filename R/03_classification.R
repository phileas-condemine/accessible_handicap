library(data.table)
library(plotly)
library(dplyr)
library(rpart)
library(visNetwork) 
library(sparkline)
library(MLmetrics)

source("R/utils/custom_funs.R",local = T,encoding = "UTF-8")
source("R/utils/feature_eng.R",local = T,encoding = "UTF-8")
handicap = fread("data/data-es.csv",encoding = "UTF-8")
source("R/utils/vars_categ_manuelle.R",local = T,encoding = "UTF-8")
inplace_recode_features(handicap)

setnames(handicap,c("Accessibilité aux personnes à mobilité réduite à l'aire de jeu",
                    "Accessibilité aux personnes en situation de handicap sensoriel à l'aire de jeu"),
         c("OK_PRATIQUE_HM","OK_PRATIQUE_HS"))
handicap[, `:=`(
  famille_effectif = .N
), by = "Famille d'équipement sportif"]


handicap$id = 1:nrow(handicap)

train_ids = sample(handicap$id,size = 1E+5,prob = 1/handicap$famille_effectif)

train = handicap[id%in%train_ids,c(a_tester,a_tester_recodee,"OK_PRATIQUE_HM","OK_PRATIQUE_HS"),with=F]
test = handicap[!id%in%train_ids,c(a_tester,a_tester_recodee,"OK_PRATIQUE_HM","OK_PRATIQUE_HS"),with=F]


list2env(add_target_encoding(train,test,"Famille d'équipement sportif",alias="famille"),envir = environment())
list2env(add_target_encoding(train,test,"Type d'équipement sportif",alias="type"),envir = environment())
list2env(add_target_encoding(train,test,"Niveau de difficulté le plus élevé",alias="niveau_max"),envir = environment())
list2env(add_target_encoding(train,test,"Niveau de difficulté le plus bas",alias="niveau_min"),envir = environment())

to_remove = c(
  "Famille d'équipement sportif",
  "Type d'équipement sportif",
  "Niveau de difficulté le plus élevé",
  "Niveau de difficulté le plus bas"
)
train = train[,-to_remove,with=F]
test = test[,-to_remove,with=F]

train <- fix_names_encoding(train)
test <- fix_names_encoding(test)


##### HANDICAP MOTEUR #####

##### TREE ##### 
model <- rpart(OK_PRATIQUE_HM~.,data=train[,-c("OK_PRATIQUE_HS"),with=F],
               control = rpart.control(cp = 0.001))
g <- visTree(model)
g 
test$pred = predict(model,test)
AUC2(y_true = test[!is.na(OK_PRATIQUE_HM)]$OK_PRATIQUE_HM*1,
     y_pred = test[!is.na(OK_PRATIQUE_HM)]$pred)


##### GLM ##### 

model = two_step_glm(train,"OK_PRATIQUE_HM",output = "model")
# coeffs[order(Estimate,decreasing = T)]


test$pred = predict(model,test)
AUC2(y_true = test[!is.na(OK_PRATIQUE_HM)]$OK_PRATIQUE_HM*1,
     y_pred = test[!is.na(OK_PRATIQUE_HM)]$pred)

##### SVM #####
library(LiblineaR)
library(glmnet)
test$pred=NULL
trainHM = train[!is.na(OK_PRATIQUE_HM)]
testHM = test[!is.na(OK_PRATIQUE_HM)]

l <- makeX(trainHM[,-c("OK_PRATIQUE_HS","OK_PRATIQUE_HM"),with=F],
           testHM[,-c("OK_PRATIQUE_HS","OK_PRATIQUE_HM"),with=F]
           ,na.impute = T
           )

trainX = l$x%>% data.frame
testX = l$xtest%>% data.frame

# trainX <- trainX  %>% mutate_all(function(x)case_when(is.na(x)~-1,T~x))
# testX <- testX  %>% mutate_all(function(x)case_when(is.na(x)~-1,T~x))


model <- LiblineaR::LiblineaR(trainX,trainHM$OK_PRATIQUE_HM)

testX$OK_PRATIQUE_HM = testHM$OK_PRATIQUE_HM
liblinearpred = predict(model,testX)
testX$pred = liblinearpred$predictions
# AUC2(y_true = testX$OK_PRATIQUE_HM*1,
#      y_pred = testX$pred)
MLmetrics::Accuracy(testX$pred ,  testX$OK_PRATIQUE_HM*1)

##### GLM en sélectionnant MODALITE PAR MODALITE ET NON VARIABLE PAR VARIABLE ##### 

trainX$OK_PRATIQUE_HM = trainHM$OK_PRATIQUE_HM
trainX = data.table(trainX)
testX = data.table(testX)
model = two_step_glm(trainX,"OK_PRATIQUE_HM",output = "model")
# coeffs[order(Estimate,decreasing = T)]


test$pred = predict(model,test)
AUC2(y_true = test[!is.na(OK_PRATIQUE_HM)]$OK_PRATIQUE_HM*1,
     y_pred = test[!is.na(OK_PRATIQUE_HM)]$pred)
