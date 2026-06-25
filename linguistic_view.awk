BEGIN{
  a[">><"]="-"
  a["><"]="."
  a[">$"]=""
  a["^<"]=""
  b["[<>]"]="."
}
{
  for (k in a) gsub(k, a[k])
  for (k in b) gsub(k, b[k])
  print
}
