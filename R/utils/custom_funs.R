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

two_step_glm = function(dt,target){
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
  nm = names(dt)
  to_fix = nm[!validUTF8(nm)]
  to_fix <- iconv(to_fix,to="UTF-8")
  names(dt)[!validUTF8(nm)] <- iconv(to_fix,from="UTF-8",to="ASCII//TRANSLIT")
  names(dt)[validUTF8(nm)] <- iconv(names(dt)[validUTF8(nm)],from="UTF-8",to="ASCII//TRANSLIT")
  names(dt) <- gsub(" ","_",names(dt))
  names(dt) <- gsub("'",".",names(dt))
  setnames(dt,target,"target")
  model <- glm(target~.+0,data=dt)
  summary(model)
  coefs <- summary(model)$coefficients
  vars <- rownames(coefs)[which(coefs[, 4] < 0.01)]
  var_mod = rbindlist(lapply(names(dt),function(var){
    data.table(var=var,mod=unique(dt[[var]]))
  }))
  var_mod[,coeff:=paste0(var,mod)]
  vars_signif = unique(var_mod[coeff%in%vars]$var)
  model <- glm(target~.+0,data=dt[,c(vars_signif,"target"),with=F])
  summary(model)
  coeffs <- summary(model)$coefficients
  coeffs = data.table(coeffs,keep.rownames = "var")
  coeffs
}
