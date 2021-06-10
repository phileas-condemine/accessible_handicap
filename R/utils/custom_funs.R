count_and_plot = function(data,var){
  stats = data[,.N,by=var]
  setnames(stats,var,"x")
  setorder(stats,-N)
  stats[,x:=factor(x)]
  stats[,x:=forcats::fct_inorder(x)]
  plot_ly(data=stats,x=~x,y=~N)
}
show_pct = function(x)paste0(round(100*x,1),"%")
find_mods = function(one_var,data=handicap){
  vec = unique(data[[one_var]])
  vec = gsub("(^\\{)|(\\}$)","",vec)
  vec = strsplit(vec,",")
  vec = unique(unlist(vec))
  vec = gsub('"','',vec)
  vec
}

plot_margin = function(coeffs,pattern,signif=0.01){
  var_coeffs = coeffs[grep(pattern,var)]
  var_coeffs = var_coeffs[`Pr(>|t|)`<signif]
  var_coeffs$var = forcats::fct_inorder(var_coeffs$var)
  g <- ggplot(var_coeffs)+
    geom_point(aes(x=var,y=Estimate))
  ggplotly(g)
}


fix_names_encoding = function(dt){
  nm = names(dt)
  to_fix = nm[!validUTF8(nm)]
  to_fix <- iconv(to_fix,to="UTF-8")
  names(dt)[!validUTF8(nm)] <- iconv(to_fix,from="UTF-8",to="ASCII//TRANSLIT")
  names(dt)[validUTF8(nm)] <- iconv(names(dt)[validUTF8(nm)],from="UTF-8",to="ASCII//TRANSLIT")
  names(dt) <- gsub(" ","_",names(dt))
  names(dt) <- gsub("'",".",names(dt))
  dt
}


two_step_glm = function(dt,target,output="coeffs"){
  dt = dt[,sapply(dt,function(x)uniqueN(na.omit(x)))>1,with=F]
  dt = dt%>%mutate_if(is.logical,function(x){
    case_when(is.na(x) ~ F,
              T ~ x)
  })
  dt = dt%>%mutate_if(is.integer,function(x){
    case_when(is.na(x) ~ 0L,
              T ~ x)
  })
  dt = dt%>%mutate_if(is.double,function(x){
    case_when(is.na(x) ~ 0,
              T ~ x)
  })
  dt <- fix_names_encoding(dt)
  setnames(dt,target,"target")
  model <- glm(target~.+0,data=dt)
  summary(model)
  coefs <- summary(model)$coefficients
  vars <- rownames(coefs)[which(coefs[, 4] < 0.01)]
  var_mod = rbindlist(lapply(names(dt),function(var){
    data.table(var=var,mod=unique(dt[[var]]))
  }))
  var_mod[,coeff:=paste0(var,mod)]
  vars_signif = unique(var_mod[coeff%in%vars | var%in%vars]$var)
  model <- glm(target~.+0,data=dt[,c(vars_signif,"target"),with=F])
  summary(model)
  coeffs <- summary(model)$coefficients
  coeffs = data.table(coeffs,keep.rownames = "var")
  if(output=="coeffs"){
    return(coeffs)
  } else if (output=="model"){
    return(model)
  } else {
    stop("wrong output value, should be coeffs or model")
  }
}

add_target_encoding = function(train,test,var,min_size=100,alias){
  assertthat::assert_that(var %in% names(train),msg=sprintf('"%s" should be in train',var))
  assertthat::assert_that(var %in% names(test),msg=sprintf('"%s" should be in test',var))
  target_encoding = train[, .(
    N=.N,
    avg_access_hm = mean(OK_PRATIQUE_HM, na.rm = T), #target encoding
    avg_access_hs = mean(OK_PRATIQUE_HS, na.rm = T) #target encoding
  ), by = var]
  setnames(target_encoding,c("avg_access_hm","avg_access_hs"),
           c(paste0(alias,"_avg_access_hm"),paste0(alias,"_avg_access_hs")))
  n=nrow(target_encoding)
  target_encoding = target_encoding[N>min_size,-c("N")]
  n2=nrow(target_encoding)
  print(sprintf("Avec le filtrage sur min_size on passe de %s modalités à %s",n,n2))
  train = merge(train,target_encoding,by=var,all.x=T)
  test = merge(test,target_encoding,by=var,all.x=T)
  list("train"=train,"test"=test)
}

AUC2 = function (y_pred, y_true) {
  rank <- rank(y_pred)
  n_pos <- sum(y_true == 1)
  n_neg <- sum(y_true == 0)
  AUC <- (sum(rank[y_true == 1]) - n_pos * (n_pos + 1)/2)
  AUC <- AUC / n_pos  
  AUC <- AUC / n_neg  
  return(AUC)
}
