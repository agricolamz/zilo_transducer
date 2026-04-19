suppressPackageStartupMessages(library(tidyverse))

"# -------------------------------------------------------------------------
# DO NOT EDIT! THIS FILE IS CREATED AUTOMATICALLY!
# -------------------------------------------------------------------------
" |> 
  write_lines("ani_adjectives_lexicon.lexd")


read_csv("data/dictionary.csv",
         show_col_types = FALSE, 
         progress = FALSE) |> 
  filter(pos == "ADJ",
         str_detect(zilo, "\\s", negate = TRUE)) |> 
  mutate(zilo = str_replace_all(zilo, "[1ӏ]", "I"),
         transducer_entry = str_replace_all(transducer_entry, "[1ӏ]", "I"),
         transducer_entry = str_pad(transducer_entry, side = "right", width = 60),
         transducer_entry = str_c(transducer_entry, "# ", russian)) |> 
  select(transducer_entry, transducer_lexicon_group) |> 
  arrange(transducer_lexicon_group) |> 
  mutate(transducer_lexicon_group = str_c("LEXICON ", transducer_lexicon_group)) |> 
  group_by(transducer_lexicon_group) |> 
  summarise(transducer_entry = str_c(transducer_entry, collapse = "\n")) |> 
  ungroup() |> 
  mutate(result = str_c(transducer_lexicon_group, "\n\n", transducer_entry, "\n\n")) |> 
  pull(result) |> 
  write_lines("ani_adjectives_lexicon.lexd", append = TRUE)
