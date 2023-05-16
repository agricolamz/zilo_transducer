suppressPackageStartupMessages(library(tidyverse))
df <- readxl::read_xlsx("dicts/andic_all_merged.xlsx")

df |>
  filter(!is.na(gender),
         !str_detect(base, "[,;]"),
         !str_detect(abs.pl, "[,;]"),
         !str_detect(obl.sg, "[,;]"),
         !str_detect(obl.pl, "[,;]")) |>
  arrange(gender) |>
  select(base, abs.pl, obl.sg, obl.pl, gender, meaning_ru) |>
  mutate(gender = ifelse(gender == "б, р/б, б/р, р", "р, р", gender)) |> 
  add_count(gender) |>  
  arrange(-n, base) ->
  for_noun_dict

for_noun_dict |>
  arrange(gender, base) |>
  mutate(base = case_when(gender == "в, в" ~ str_c(base, "[m]"),
                          gender == "й, й" ~ str_c(base, "[f]"),
                          gender == "б, й" ~ str_c(base, "[an]"),
                          gender == "б, б" ~ str_c(base, "[inan1]"),
                          gender == "р, р" ~ str_c(base, "[inan2]")),
         base = str_pad(base, 60, side = "right"),
         base = str_c(base, "# ", meaning_ru, ";")) |>
  pull(base) ->
  abs.sg_forms

for_noun_dict |>
  arrange(gender, base) |>
  mutate(base = case_when(gender == "в, в" ~ str_c(base, "<obl>:", obl.sg, "[m]"),
                          TRUE ~ str_c(base, "<N><obl>:", obl.sg)),
         base = str_remove(base, "лIи$"),
         base = str_remove(base, "ув$"),
         base = str_pad(base, 60, side = "right"),
         base = str_c(base, "# ", meaning_ru, ";")) |>
  pull(base) ->
  obl.sg_forms

for_noun_dict |>
  arrange(gender, base) |>
  mutate(base = case_when(gender == "в, в" ~ str_c(base, "<pl>:", abs.pl, "[m]"),
                          TRUE ~ str_c(base, "<N><pl>:", abs.pl)),
         base = str_pad(base, 60, side = "right"),
         base = str_c(base, "# ", meaning_ru, ";")) |>
  pull(base) ->
  abs.pl_forms

for_noun_dict |>
  arrange(gender, base) |>
  mutate(base = case_when(gender == "в, в" ~ str_c(base, "<obl.pl>:", obl.pl, "[m]"),
                          TRUE ~ str_c(base, "<N><obl.pl>:", obl.pl)),
         base = str_remove(base, "лIи$"),
         base = str_remove(base, "в$"),
         base = str_pad(base, 60, side = "right"),
         base = str_c(base, "# ", meaning_ru, ";")) |>
  pull(base) ->
  obl.pl_forms

header <- "# -------------------------------------------------------------------------
# NOUN LEXICON
# -------------------------------------------------------------------------"

c(header, "\n\n",
  "LEXICON NounAbs", abs.sg_forms, "\n",
  "LEXICON NounObl", obl.sg_forms, "\n",
  "LEXICON NounAbsPl", abs.pl_forms, "\n",
  "LEXICON NounOblPl", obl.pl_forms, "\n") |>
  write_lines("ani_lex_nouns.lexd")

