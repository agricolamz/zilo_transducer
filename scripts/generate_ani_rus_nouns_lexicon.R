suppressPackageStartupMessages(library(tidyverse))

"# -------------------------------------------------------------------------
# DO NOT EDIT! THIS FILE IS CREATED AUTOMATICALLY!
# -------------------------------------------------------------------------
" |> 
  write_lines("ani_nouns_lexicon.lexd")

read_csv("data/dictionary.csv",
         show_col_types = FALSE, 
         progress = FALSE) |> 
  filter(pos == "N",
         str_detect(zilo, "\\s", negate = TRUE)) |>
  mutate(zilo = str_replace_all(zilo, "[1ӏ]", "I"),
         transducer_entry = zilo,
         transducer_entry = str_replace_all(transducer_entry, "[1ӏ]", "I"),
         transducer_entry = str_pad(transducer_entry, side = "right", width = 60),
         transducer_entry = str_c(transducer_entry, "# ", russian),
         transducer_lexicon_group = "Nouns_Abs_Sg") |> 
  select(transducer_entry, transducer_lexicon_group) |> 
  mutate(transducer_lexicon_group = str_c("LEXICON ", transducer_lexicon_group)) |> 
  group_by(transducer_lexicon_group) |> 
  summarise(transducer_entry = str_c(transducer_entry, collapse = "\n")) |> 
  ungroup() |> 
  mutate(result = str_c(transducer_lexicon_group, "\n\n", transducer_entry, "\n\n")) |> 
  select(result) |> 
  na.omit() |> 
  pull(result) |> 
  write_lines("ani_nouns_lexicon.lexd", append = TRUE)

read_csv("data/dictionary.csv",
         show_col_types = FALSE, 
         progress = FALSE) |> 
  filter(pos == "N",
         str_detect(zilo, "\\s", negate = TRUE)) |>
  mutate(zilo = str_replace_all(zilo, "[1ӏ]", "I"),
         abs.pl = str_replace_all(abs.pl, "[1ӏ]", "I"),
         abs.pl = str_split(abs.pl, ", ")) |> 
  unnest_longer(abs.pl) |> 
  mutate(transducer_entry = str_c(zilo, "<pl>:", abs.pl),
         transducer_entry = str_pad(transducer_entry, side = "right", width = 60),
         transducer_entry = str_c(transducer_entry, "# ", russian),
         transducer_lexicon_group = "Nouns_Abs_Pl") |> 
  select(transducer_entry, transducer_lexicon_group) |> 
  na.omit() |> 
  mutate(transducer_lexicon_group = str_c("LEXICON ", transducer_lexicon_group)) |> 
  group_by(transducer_lexicon_group) |> 
  summarise(transducer_entry = str_c(transducer_entry, collapse = "\n")) |> 
  ungroup() |> 
  mutate(result = str_c(transducer_lexicon_group, "\n\n", transducer_entry, "\n\n")) |> 
  select(result) |> 
  na.omit() |> 
  pull(result) |> 
  write_lines("ani_nouns_lexicon.lexd", append = TRUE)

read_csv("data/dictionary.csv",
         show_col_types = FALSE, 
         progress = FALSE) |> 
  filter(pos == "N",
         str_detect(zilo, "\\s", negate = TRUE)) |> 
  mutate(zilo = str_replace_all(zilo, "[1ӏ]", "I"),
         obl.sg = str_replace_all(obl.sg, "[1ӏ]", "I"),
         obl.sg = str_split(obl.sg, ", ")) |> 
  unnest_longer(obl.sg) |> 
  filter(str_detect(obl.sg, "\\s", negate = TRUE)) |> 
  mutate(obl.sg = str_remove(obl.sg, "(шу[вйбр]$)|(лIи$)")) |> 
  distinct(russian, zilo, obl.sg, gender) |>
  mutate(obl.sg = if_else(str_detect(gender, "в"), str_c(obl.sg, "шу[m]"), obl.sg)) |> 
  mutate(transducer_entry = str_c(zilo, "<obl>:", obl.sg),
         transducer_entry = case_when(transducer_entry == "воцци<obl>:воццувшу[m]" ~ "воцци<obl>:воццу[m]",
                                      transducer_entry == "дада<obl>:дадавшу[m]" ~ "дада<obl>:дада[m]",
                                      transducer_entry == "има<obl>:имувшу[m]" ~ "има<obl>:иму[m]",
                                      transducer_entry == "кунтIа<obl>:кунтIувшу[m]" ~ "кунтIа<obl>:кунтIу[m]",
                                      TRUE ~ transducer_entry),
         transducer_entry = str_pad(transducer_entry, side = "right", width = 60),
         transducer_entry = str_c(transducer_entry, "# ", russian),
         transducer_lexicon_group = "Nouns_Obl") |> 
  select(transducer_entry, transducer_lexicon_group) |> 
  na.omit() |> 
  mutate(transducer_lexicon_group = str_c("LEXICON ", transducer_lexicon_group)) |> 
  group_by(transducer_lexicon_group) |> 
  summarise(transducer_entry = str_c(transducer_entry, collapse = "\n")) |> 
  ungroup() |> 
  mutate(result = str_c(transducer_lexicon_group, "\n\n", transducer_entry, "\n\n")) |> 
  select(result) |> 
  na.omit() |> 
  pull(result) |> 
  write_lines("ani_nouns_lexicon.lexd", append = TRUE)

read_csv("data/dictionary.csv",
         show_col_types = FALSE, 
         progress = FALSE) |> 
  filter(pos == "N",
         str_detect(zilo, "\\s", negate = TRUE)) |> 
  mutate(zilo = str_replace_all(zilo, "[1ӏ]", "I"),
         obl.pl = str_replace_all(obl.pl, "[1ӏ]", "I"),
         obl.pl = str_split(obl.pl, ", ")) |> 
  unnest_longer(obl.pl) |> 
  filter(str_detect(obl.pl, "\\s", negate = TRUE)) |> 
  mutate(obl.pl = str_remove(obl.pl, "([вйбр](ул)?$)|(лIи$)|(лIол$)")) |> 
  distinct(russian, zilo, obl.pl, obl.pl, gender) |>
  mutate(obl.pl = if_else(str_detect(gender, "в"), str_c(obl.pl, "[m]"), obl.pl)) |> 
  mutate(transducer_entry = str_c(zilo, "<obl><pl>:", obl.pl),
         transducer_entry = case_when(transducer_entry == "воцци<obl><pl>:воццулув[m]" ~ "воцци<obl><pl>:воццулу[m]",
                                      transducer_entry == "дада<obl><pl>:дадалав[m]" ~ "дада<obl><pl>:дадала[m]",
                                      transducer_entry == "има<obl><pl>:имадав[m]" ~ "има<obl><pl>:имада[m]",
                                      transducer_entry == "кунтIа<obl><pl>:кунтIувшу[m]" ~ "кунтIа<obl><pl>:кунтIоба[m]",
                                      TRUE ~ transducer_entry),
         transducer_entry = str_pad(transducer_entry, side = "right", width = 60),
         transducer_entry = str_c(transducer_entry, "# ", russian),
         transducer_lexicon_group = "Nouns_Obl_Pl") |> 
  select(transducer_entry, transducer_lexicon_group) |> 
  na.omit() |> 
  mutate(transducer_lexicon_group = str_c("LEXICON ", transducer_lexicon_group)) |> 
  group_by(transducer_lexicon_group) |> 
  summarise(transducer_entry = str_c(transducer_entry, collapse = "\n")) |> 
  ungroup() |> 
  mutate(result = str_c(transducer_lexicon_group, "\n\n", transducer_entry, "\n\n")) |> 
  select(result) |> 
  na.omit() |> 
  pull(result) |> 
  write_lines("ani_nouns_lexicon.lexd", append = TRUE)