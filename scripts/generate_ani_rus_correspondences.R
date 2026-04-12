suppressPackageStartupMessages(library(tidyverse))

"PATTERNS
translations

LEXICON translations
" |> 
  write_lines("ani_rus.lexd")

read_csv("data/dictionary.csv",
         show_col_types = FALSE, 
         progress = FALSE) |> 
  filter(str_detect(russian, "\\s", negate = TRUE),
         str_detect(zilo, "\\s", negate = TRUE)) |> 
  mutate(zilo = str_replace_all(zilo, "[1I]", "ӏ"),
         result = str_c(zilo, ":", russian)) |> 
  arrange(result) |> 
  pull(result) |> 
  write_lines("ani_rus.lexd", append = TRUE)

read_lines("data/ani_rus_addendum.txt") |> 
  write_lines("ani_rus.lexd", append = TRUE)

system("hfst-dump-alphabets -1 ani_generator.hfst", intern = TRUE) |> 
  str_subset(">") |> 
  write_lines("ani_rus.lexd", append = TRUE)
