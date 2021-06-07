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