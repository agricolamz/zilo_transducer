setwd("/home/agricolamz/work/applications/zilo_transducer")
all_forms <- system("hfst-fst2strings ani_generator.hfst", intern = TRUE)

library(tidyverse)
all_forms |> 
  str_extract("^.*?:") |> 
  str_remove_all("[:<>A-z\\d\\.]") |> 
  unique() |> 
  sort() ->
  lemmata
  