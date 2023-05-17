suppressPackageStartupMessages(library(tidyverse))
"# -------------------------------------------------------------------------
# PRONOUNS
# -------------------------------------------------------------------------

PATTERNS
Pronouns

LEXICON Pronouns
" |> 
  write_lines("ani_lex_pronouns.lexd")

read_csv("dictionary.csv", show_col_types = FALSE) |> 
  filter(pos == "pronoun",
         is.na(ignore)) |> 
  mutate(translation_en = ifelse(is.na(translation_en), "", translation_en),
         generate = str_c(lemma, ":", form),
         generate = str_pad(generate, width = 60, side = "right"),
         generate = str_c(generate, "# ", translation_ru, "; ", translation_en)) |> 
  pull(generate) |> 
  append(x = _, "\n") |> 
  write_lines("ani_lex_pronouns.lexd", append = TRUE)
