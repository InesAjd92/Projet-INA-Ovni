
# MIP Ovni

# Corpus OVNI

# Informations sur les colonnes


# Contexte de l'analyse ---------------------------------------------------

# Dans le cadre d'un objet de travail sur les archives numériques de l'INA, nous avons choisi de parler du sujet des OVNI et extraterrestres. 
# Nous souhaitons savoir si il existe une différence de représentation selon les médias de communication. 

# Pour cela, nous avons établi des questions de recherche  

# -1/
# -2/ ...

# Importation des données & backup

data_ovni <- read_delim("data_importantes/data_ovni.csv", 
                        delim = ";", 
                        escape_double = FALSE, 
                        locale = locale(encoding = "ISO-8859-1"), 
                        trim_ws = TRUE)
backup_data <- data_ovni



# Appropriation et nettoyage des données ----------------------------------

# a) Chargement des librairies

library(tidyverse)
library(skimr)
library(rstatix)
library(questionr)
library(readr)
library(tidyverse)


data_tibble <- as.tibble(data_ovni)
data_tibble


# Apercu des donnees

data_tibble %>% 
  summary()

# Probleme de type des données à changer

data_tibble

data_tibble$notice <- as.character (data_tibble$notice)
data_tibble$`Année de date_diffusion` <- as.character (data_tibble$`Année de date_diffusion`)
data_tibble$`Année de decennie` <- as.character (data_tibble$`Année de decennie`)
data_tibble$chaine <- as.factor(data_tibble$chaine)
data_tibble$public_groupe <- as.factor(data_tibble$public_groupe)
data_tibble$mediamat_groupe <- as.factor(data_tibble$mediamat_groupe)
data_tibble$genre_groupe <- as.factor(data_tibble$genre_groupe)

# Le reste c'est ok !

# Les chaînes les plus anciennes (plus de notice dans des dates les plus anciennes)
# Les chaînes qui en parlent plus fréquemment (plus de notices)
# Comparaison entre les chaînes en termes de nombre de notice (classement)
# Les mediamat_groupe les plus populaires (audience ou part_de_marche)

# Trouver la notice la plus ancienne dans l'ensemble des données

# Trier les données par ordre croissant de la colonne "Année de date_diffusion"
data_tri <- data_tibble[order(data_tibble$`Année de date_diffusion`), ]

# Sélectionner la première ligne (la plus ancienne)
premiere_notice <- data_tri[1, ]

# Extraire la chaîne associée à cette notice
chaine_plus_ancienne <- premiere_notice$chaine

# Afficher le résultat
print(chaine_plus_ancienne)

#TF1 a été la premiere chaine a parler des ovni lors d'un débat consacré aux ovni 

# Chaines qui en parlent le plus

# Compter le nombre de notices par chaîne
notices_par_chaine <- data_tibble %>%
  group_by(chaine) %>%
  summarise(nombre_notices = n())

# Classer les chaînes en fonction du nombre de notices (du plus grand au plus petit)
chaine_plus_frequente <- notices_par_chaine %>%
  arrange(desc(nombre_notices))

# Afficher le résultat
print(chaine_plus_frequente)


# France 4 (116) et  RMC Story (70) sont les chaines qui parlent le plus d'OVNI 



# TOP 5 des  chaînes qui ont le plus grand nombre de notices

chaines_plus_frequentes <- chaine_plus_frequente$chaine[1:5]  # Sélectionnez les 5 chaînes ayant le plus grand nombre de notices (vous pouvez ajuster ce nombre si nécessaire)

# Filtrer les données pour inclure uniquement les notices associées à ces chaînes
donnees_chaines_plus_frequentes <- subset(data_tibble, chaine %in% chaines_plus_frequentes)

# Répartition des mediamat_group pour les chaînes sélectionnées
repartition_mediamat <- table(donnees_chaines_plus_frequentes$mediamat_groupe)

# Répartition des genre_group pour les chaînes sélectionnées
repartition_genre <- table(donnees_chaines_plus_frequentes$genre_groupe)

# Afficher les résultats

print(repartition_mediamat)


## Interprétation des résultats :
# - "Culture connaissance": Il y a 98 notices qui sont classées dans la catégorie "Culture connaissance". Cela suggère que les chaînes sélectionnées diffusent un contenu axé sur la culture et la connaissance.
# - "Fiction": Il y a 167 notices qui sont classées dans la catégorie "Fiction". Cela indique que les chaînes diffusent également des programmes de fiction.
# - "Information": Il n'y a aucune notice qui est classée dans la catégorie "Information". Cela peut signifier que les chaînes sélectionnées ne diffusent pas de programmes d'information ou qu'il y a eu une absence de classification pour ce type de contenu dans les données.
# - "Jeunesse": Il y a 1 notice qui est classée dans la catégorie "Jeunesse". Cela suggère qu'il y a un faible nombre de programmes destinés aux jeunes diffusés sur ces chaînes.
# - "Variétés divertissement": Il y a 4 notices qui sont classées dans la catégorie "Variétés divertissement". Cela indique que les chaînes sélectionnées diffusent également des programmes de divertissement variés.

print(repartition_genre)

## Répartition des genre_group :
# - "Animation": Il y a 162 notices qui sont classées dans la catégorie "Animation". Cela suggère que les chaînes diffusent un nombre significatif de programmes animés.
# - "Documentaire": Il y a 72 notices qui sont classées dans la catégorie "Documentaire". Cela indique que les chaînes diffusent également des documentaires.
# - "Feuilleton": Il n'y a aucune notice qui est classée dans la catégorie "Feuilleton". Cela peut signifier que les chaînes sélectionnées ne diffusent pas de feuilletons ou qu'il y a eu une absence de classification pour ce type de contenu dans les données.
# - "Long métrage": Il y a 3 notices qui sont classées dans la catégorie "Long métrage". Cela suggère que les chaînes diffusent occasionnellement des longs métrages.
# - "Magazine": Il y a 31 notices qui sont classées dans la catégorie "Magazine". Cela indique que les chaînes diffusent également des magazines télévisés.
# - "Série": Il y a 1 notice qui est classée dans la catégorie "Série". Cela suggère que les chaînes diffusent également des séries télévisées.
# - "Tranche horaire": Il y a 1 notice qui est classée dans la catégorie "Tranche horaire". Cela peut indiquer une classification spécifique liée aux horaires de diffusion.




library(ggplot2)
library(dplyr)

# 1. Calculer le nombre de notices par décennie
nombre_notices_par_decennie <- data_tibble %>%
  group_by(`Année de decennie`) %>%
  summarise(nombre_notices = n())


# 3. Calculer le taux de variation pertinent entre chaque décennie
taux_variation <- nombre_notices_par_decennie %>%
  mutate(taux_variation = (nombre_notices - lag(nombre_notices)) / lag(nombre_notices) * 100)

# Afficher le taux de variation
print(taux_variation)


#Pour la décennie 1990, il y a 15 notices et le taux de variation n'est pas calculé car il n'y a pas de décennie précédente pour la comparer.#
#Pour la décennie 2000, il y a 34 notices et le taux de variation est de 127%, ce qui signifie qu'il y a eu une augmentation de 127% par rapport à la décennie précédente (1990).#
#Pour la décennie 2010, il y a 234 notices et le taux de variation est de 588%, ce qui signifie qu'il y a eu une augmentation de 588% par rapport à la décennie précédente (2000).#
# Pour la décennie 2020, il y a 100 notices et le taux de variation est de -57.3%, ce qui signifie qu'il y a eu une diminution de 57.3% par rapport à la décennie précédente (2010).#


# 1. Calculer l'audience moyenne pour chaque mediamat_groupe
audience_moyenne_par_groupe <- data_tibble %>%
  group_by(mediamat_groupe) %>%
  summarise(audience_moyenne = mean(audience, na.rm = TRUE))


notices_meilleures_audiences <- data_tibble %>%
  group_by(mediamat_groupe) %>%
  filter(audience == max(audience, na.rm = TRUE)) %>% 
  arrange(desc(audience))  # Tri par ordre décroissant d'audience

print(audience_moyenne_par_groupe)

print(notices_meilleures_audiences)

library(dplyr)

# Identifier les notices avec les meilleures parts de marché
notices_meilleures_parts_de_marche <- data_tibble %>%
  arrange(desc(part_de_marche))  # Trier par ordre décroissant de part_de_marche
  
# Afficher les notices avec les meilleures parts de marché
print(notices_meilleures_parts_de_marche)


# Calculer le nombre total d'audience homme et d'audience femme parmi ces notices
audience_homme <- sum(notices_meilleures_parts_de_marche$audience_homme, na.rm = TRUE)
audience_femme <- sum(notices_meilleures_parts_de_marche$audience_femme, na.rm = TRUE)

# Comparer le nombre d'audience homme et d'audience femme
if (audience_homme > audience_femme) {
  cat("Il y a plus d'audience homme parmi les meilleures notices avec les meilleures parts de marché.")
} else if (audience_femme > audience_homme) {
  cat("Il y a plus d'audience femme parmi les meilleures notices avec les meilleures parts de marché.")
} else {
  cat("Il y a autant d'audience homme que d'audience femme parmi les meilleures notices avec les meilleures parts de marché.")
}



# Nombre total de notices
nombre_total_notices <- nrow(notices_meilleures_parts_de_marche)

total_audience_homme <- sum(notices_meilleures_parts_de_marche$audience_homme, na.rm = TRUE)
total_audience_femme <- sum(notices_meilleures_parts_de_marche$audience_femme, na.rm = TRUE)


# Proportion d'audience homme et d'audience femme
proportion_audience_homme <- total_audience_homme / nombre_total_notices
proportion_audience_femme <- total_audience_femme / nombre_total_notices



# Transformation iramuteq -------------------------------------------------

# Copie pour transformation iramuteq

data_iramuteq <- data_ovni

#formule 

# Data to iramuteq



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

# Mots à supprimer dans les descriptions 

mots_a_supprimer <- c("journaliste","sophie", "recette", "recettes", "david", "rubrique", "rubriques", "martin", "illustré", "brigitte", "robin", "batman", "teen", "ado", "ados", "gotham", "jump", "city", "titan", "cirque", "adolescent", "adolescents", "aventure", "tropical", "île", "tamaran", "starfire", "raven", "prince", "animation", "rythmer", "rythmé", "série", "séries","serie","series","propos", "laurent", "emission", "emissions", "guy", "canne", "cannes", "album", "albums", "salvatore", "ademo", "adamo", "chanson", "chansons", "musical", "musicaux", "generation", "generations", "tube", "tubes", "chanteur", "chanteurs", "chanteuse", "chanteuses", 'mannequin', "mannequins", "imion", "carriere", "carrieres", "souchon", "hit", "hit80", "gainsbourg", "chanter", "sarah", "bfm", "JT", "jt", "complilation", "compilations", "journal", "candidats", "candidat", "emmanuel", "zemmour", "macron", "eric", "elie", "semmoun", "collège", "collèges", "pain", "ministre", "ministres", "politique", "candidat", "candidats", "presidentielle", "lr", "election", "elections", "lepen", "sport", "vilain", "canard", "jeu", "rick", "morty", "jane", "sprirou", "mulder", "chalumeau", "belver", "julien", "ethienne", "carbonner", "maia", "bristielle", "antoine", "edition", "depétrini", "watrin", "lilia", "hassaine", "chaouch", "ahmed", "ukrainien", "valentin", "marian", "babich", "azzedine", "traducteur", "dettinger", "christophe", "police", "secretaire", "depute", "deputes", "gilet", "jaune", "general", "lrem", "pomrart", "laetitia","oise", "dewali", "perquisition", "vigi", "vigier", "syndicat","solère", "seines", "langlois" , "hugues","gitan","journalistes", "ovni", "ovnis", "extraterrestre", "extraterrestres", "source", "imedia", "sources", "actualité", "actualités", "france", "chroniqueur", "iran", "fatou","maroquinnerie", "politique", "geopolitique", "diplomatie", "frederic", "sophie", "album", "chanson", "chansons", "comédien", "comédiens", "chroniqueurs", "chronique", "entretien", "emission", "som", "sommaire", "programme", "emissions", "auteur", "auteurs","catherine", "pauline", "jean", "michel", "bill", "sacha", "paul", "emily", "nathan", "chloe", "christopher", "erika", "sofia", "sophia", "mokrani", "nadia", "daam", "patrick", "marc", "mouloud", "interview", "interviews", "roger", "lestrade", "alien", "aliens", "tele", "tv", "television", "televisions", "teles", "chaine", "chaines", "tf1", "M6", "publicité", "publicités", "direct", "directs", "maire", "maires", "nathalie", "presse", "press", "presses", "directeur", "directeurs", "européen", "europe", "européens", "renaud", "declaration", "declarations", "macron", "quantar", "melanchon", "francais", "français", "camille", "tendance", "tendances", "mode", "clique", "cliques", "recommandation", "recommandations", "prescritpions", "prescription")  


# Appliquer gsub()
data_iramuteq$resume <- gsub(paste(mots_a_supprimer, collapse="|"), "", data_iramuteq$resume, ignore.case = TRUE)

# data en format iramuteq

dataframe2iramuteq(data_iramuteq, "data_iramuteq_media_clean.txt")


library(tidyverse)
mots_a_supprimer2 <- c("di", "icke", "ita", "edge", "cutting", "david", "sub", "altra", "the", "www", "https", "http", "com", "franã", "â", "ã", "rã", "vã", "dã", "prã", "mã", "tã", "cinã", "lã", "sociã", "nousã", "quatriã", "enfantsã", "sociã", "extraterrestres", "extraterrestre", "ovni", "ovnis", "alien", "aliens", "alieno", "alieni", "alienígenas", "alienígena", "hd", "HD", "semaine", "semaines", "nousã", "rajouter", "quatriã", "enfantsã", "sociã", "trouver", "nomã", "phã", "r", "btlv", "res", "poser", "quotidiennement", "poser", "devenir", "cas", "YouTube", "watch", "wat", "aise", "version", "channels", "channel", "vidã", "nhttps", "novni") 

# Appliquer gsub()
notices_web_descriptions_iramuteq $Description <- gsub(paste(mots_a_supprimer2, collapse="|"), "", notices_web_descriptions_iramuteq$Description, ignore.case = TRUE)

# data en format iramuteq

dataframe2iramuteq(notices_web_descriptions_iramuteq, "data_iramuteq_web_description.txt")
dataframe2iramuteq(notices_web_titres_iramuteq, "notices_web_titres_iramuteq.txt")
