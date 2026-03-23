library(tidyverse)

dataframe2iramuteq <- function(data, filename) {
  data %>% 
    rename_with(~str_replace_all(str_to_lower(.), "[\\W_]+", "")) %>% # clean column names
    drop_na() %>%
    mutate(across(1:ncol(.)-1, ~str_replace_all(., "[\\W_]+", "")), row = 1:n()) %>% # clean values
    pivot_longer(-row, names_to = "coln", values_to = "value") %>%
    group_by(row) %>%
    summarise(text = str_c("** ", str_c("*", coln[-n()], "_", value[-n()], collapse = " "), "\n", last(value))) %>% 
    summarise(text = str_c(text, collapse = "\n")) %>% 
    pull(1) %>% 
    write_file(filename)
}

library(readr)

notices_web_titres_iramuteq <- read_csv("notices_web_titres_iramuteq.csv")

dataframe2iramuteq(notices_web_titres_iramuteq, "data_iramuteq_web_titres.txt")



# Data to iramuteq



dataframe2iramuteq <- function(data, filename) {
  data %>% 
    rename_with(~str_replace_all(str_to_lower(.), "[\\W_]+", "")) %>% # clean column names
    drop_na() %>%
    mutate(across(1:ncol(.)-1, ~str_replace_all(., "[\\W_]+", "")), row = 1:n()) %>% # clean values
    pivot_longer(-row, names_to = "coln", values_to = "value") %>%
    group_by(row) %>%
    summarise(text = str_c("** ", str_c("*", coln[-n()], "_", value[-n()], collapse = " "), "\n", last(value))) %>% 
    summarise(text = str_c(text, collapse = "\n")) %>% 
    pull(1) %>% 
    write_file(filename)
}

# Mots à supprimer dans les descriptions 

mots_a_supprimer <- c("di", "icke", "ita", "edge", "cutting", "david", "sub", "altra", "the", "www", "https", "http", "com", "franã", "â", "ã", "rã", "vã", "dã", "prã", "mã", "tã", "cinã", "lã", "sociã", "nousã", "quatriã", "enfantsã", "sociã", "extraterrestres", "extraterrestre", "ovni", "ovnis", "alien", "aliens", "alieno", "alieni", "alienígenas", "alienígena", "hd", "HD", "semaine", "semaines", "nousã", "rajouter", "quatriã", "enfantsã", "sociã", "trouver", "nomã", "phã", "r", "btlv", "res", "poser", "quotidiennement", "poser", "devenir", "cas", "YouTube", "watch", "wat", "aise", "version", "channels", "channel", "vidã", "nhttps", "novni") 

# Appliquer gsub()
notices_web_descriptions_iramuteq $Description <- gsub(paste(mots_a_supprimer, collapse="|"), "", notices_web_descriptions_iramuteq$Description, ignore.case = TRUE)

# data en format iramuteq

dataframe2iramuteq(notices_web_descriptions_iramuteq, "data_iramuteq_web_description.txt")


