# Analyse des représentations médiatiques des OVNI et extraterrestres dans les médias français depuis 1967

## Contexte
Ce projet fait partie du Séminaire MIP - Explorations numériques des archives INA, en collaboration avec EUR ArTec, Université Paris Nanterre.  

Sujet n°11 : "La vie, entre controverses et défis"  
Projet encadré par Camille Claverie et Marta Severo.

L’objectif : analyser un corpus multimédia de 5 328 notices INA sur les OVNI et extraterrestres à l’aide de IRaMuTeQ et de la classification de Reinert.

---

## Objectifs de recherche
- Identifier les différences de représentation selon les médias
- Étudier le scepticisme ou la crédulité médiatique
- Explorer l’influence des supports médiatiques sur la perception publique
- Détecter les critères différenciant les médias : scientifique, sensationnel, fictionnel

---

## Corpus et sources

| Type de média | Description |
|---------------|-------------|
| Journaux télévisés | JT nationaux INA depuis 1967 (résumés et titres analysés) |
| Magazines | Presse magazine — notices descriptives et champs textuels |
| Documentaires | TV — descriptions longues, factuel ou sensationnel |
| Fictions + Web | Contenus fictionnels et web, titres et descriptions analysés séparément |

- Corpus initial : 5 328 notices
- Corpus filtré : 990 notices
- Période : 1967 à 2024

---

## Méthodologie
- Conversion du corpus au format IRaMuTeQ via `dataframe2iramuteq()` (script R)
- Nettoyage du texte : suppression des mots étrangers, URLs, émojis, noms propres non informatifs
- Classification de Reinert : regroupe les formes lexicales par indépendance statistique (chi²)
- Analyses séparées pour résumés et titres web

Technologies : R + IRaMuTeQ + Archives INA + Textométrie

---

## Résultats et conclusions
- Similitude des sujets entre médias traditionnels et web
- Classes de discours IRaMuTeQ : 
  - scientifique / institutionnel
  - populaire / complot
  - dramatique / fiction
- Hypothèses sur la perception publique non confirmées (pas de données d’audience)
- Piste future : analyse factorielle pour explorer corrélations médias ↔ registres

---

## Limites et biais
- Contamination par résumés hors sujet
- Classes génériques peu discriminantes
- Corpus biaisé vers l’audiovisuel (presse écrite sous-représentée)
- Mots étrangers, émojis et sigles parfois non filtrés

---

## Compétences mobilisées
- Analyse de corpus institutionnel réel (INA)
- Méthodes qualitatives et quantitatives
- Utilisation de R + IRaMuTeQ pour conversion, nettoyage et classification
- Travail collectif en mode sprint

---

## Liens
- [Accéder au projet sur GitHub](#)

---

## Licence
MIT License — libre de réutilisation et modification
