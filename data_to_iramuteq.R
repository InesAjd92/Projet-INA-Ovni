library(tidyverse)

dataframe2iramuteq <- function(data, filename) {
  data %>% 
    rename_with(~str_replace_all(str_to_lower(.), "[\\W_]+", "")) %>% # clean column names
    drop_na() %>%
    mutate(across(1:ncol(.)-1, ~str_replace_all(., "[\\W_]+", "")), row = 1:n()) %>% # clean values
    pivot_longer(-row, names_to = "coln", values_to = "value") %>%
    group_by(row) %>%
    summarise(text = str_c("**** ", str_c("*", coln[-n()], "_", value[-n()], collapse = " "), "\n", last(value))) %>% 
    summarise(text = str_c(text, collapse = "\n")) %>% 
    pull(1) %>% 
    write_file(filename)
}

df <- read_delim("MIP Ovni/data/data_clean_iramuteq.csv", 
                 delim = ";", escape_double = FALSE, locale = locale(encoding = "ISO-8859-1"), 
                 trim_ws = TRUE)


dataframe2iramuteq(df, "data_iramuteq.txt")


library(readr)
datafinalpouriramuteqer <- read_delim("MIP Ovni/data/datafinalpouriramuteqer.csv", 
                                      delim = ";", escape_double = FALSE, locale = locale(encoding = "ISO-8859-1"), 
                                      trim_ws = TRUE)

# Vecteur de motifs à supprimer
mots_a_supprimer <- c("journaliste", "journalistes", "ovni", "ovnis", "extraterrestre", "extraterrestres", "source", "imedia", "sources", "actualité", "actualités", "france", "chroniqueur", "chroniqueurs", "chronique", "entretien", "emission", "som", "sommaire", "programme", "emissions", "auteur", "auteurs","catherine", "pauline", "jean", "michel", "bill", "sacha", "paul", "emily", "nathan", "chloe", "christopher", "erika", "sofia", "sophia", "mokrani", "nadia", "daam", "patrick", "marc", "mouloud", "interview", "interviews", "roger", "lestrade", "alien", "aliens", "tele", "tv", "television", "televisions", "teles", "chaine", "chaines", "tf1", "M6", "publicité", "publicités", "direct", "directs", "maire", "maires", "nathalie", "presse", "press", "presses", "directeur", "directeurs", "européen", "europe", "européens", "renaud", "declaration", "declarations", "macron", "quantar", "melanchon", "francais", "français", "camille", "tendance", "tendances", "mode", "clique", "cliques", "recommandation", "recommandations", "prescritpions", "prescription")

# Appliquer gsub()
datafinalpouriramuteqer$`choix res ou resprod` <- gsub(paste(mots_a_supprimer, collapse="|"), "", datafinalpouriramuteqer$`choix res ou resprod`, ignore.case = TRUE)

dataframe2iramuteq(datafinalpouriramuteqer, "datairamuteq.txt")

dataframe2iramuteq(amina, "data_amina_iramuteq.txt")
