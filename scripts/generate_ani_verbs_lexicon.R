suppressPackageStartupMessages(library(tidyverse))

"# -------------------------------------------------------------------------
# DO NOT EDIT! THIS FILE IS CREATED AUTOMATICALLY!
# -------------------------------------------------------------------------
" |> 
  write_lines("ani_verbs_lexicon.lexd")

read_csv("data/dictionary.csv",
         show_col_types = FALSE, 
         progress = FALSE) |> 
  mutate(zilo = str_squish(zilo)) |> 
  filter(pos == "V",
         !is.na(transducer_entry),
         str_detect(zilo, "\\s", negate = TRUE)) |>
  mutate(tags = str_extract(transducer_entry, "\\[.*?\\]"),
         transducer_entry = str_replace_all(transducer_entry, "[1ӏ]", "I"),
         transducer_entry = str_pad(transducer_entry, side = "right", width = 60),
         transducer_entry = str_c(transducer_entry, "# ", russian)) |> 
  arrange(tags) |> 
  select(transducer_entry, transducer_lexicon_group) |> 
  mutate(transducer_lexicon_group = str_c("LEXICON ", transducer_lexicon_group)) |> 
  group_by(transducer_lexicon_group) |> 
  summarise(transducer_entry = str_c(transducer_entry, collapse = "\n")) |> 
  ungroup() |> 
  mutate(result = str_c(transducer_lexicon_group, "\n\n", transducer_entry, "\n\n")) |> 
  select(result) |> 
  na.omit() |> 
  pull(result) |> 
  write_lines("ani_verbs_lexicon.lexd", append = TRUE)
