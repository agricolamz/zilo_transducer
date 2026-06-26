BEGIN{
  a[">>"]="-"
  a["><"]="."
  a[">$"]=""
  a["^<"]=""
  a["[[:space:]]<"]="\t"
  a[">[[:space:]]"]="\t"
  b["-<"]="-"
  b["[<>]"]="."
}
{
  for (k in a) gsub(k, a[k])
  for (k in b) gsub(k, b[k])
  print
}
