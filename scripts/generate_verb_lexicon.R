suppressPackageStartupMessages(library(tidyverse))
"# -------------------------------------------------------------------------
# VERB LEXICON
# -------------------------------------------------------------------------

LEXICON Verbs
" |> 
  write_lines("ani_lex_verbs.lexd")

read_csv("dictionary.csv", show_col_types = FALSE) |> 
  filter(pos == "verb",
         is.na(ignore)) |> 
  add_count(tag) |> 
  arrange(-n, tag, lemma) |> 
  mutate(translation_en = ifelse(is.na(translation_en), "", translation_en),
         tag = ifelse(is.na(tag), "", str_c("[", tag, "]")),
         generate = str_c(lemma, "<V>:", form, tag),
         generate = str_pad(generate, width = 60, side = "right"),
         generate = str_c(generate, "# ", translation_ru, "; ", translation_en)) |> 
  pull(generate) |> 
  write_lines("ani_lex_verbs.lexd", append = TRUE)
