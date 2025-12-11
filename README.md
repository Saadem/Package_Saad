# STT-Descriptives : Analyse Descriptive pour R

![Status](https://img.shields.io/badge/Status-Active-success)
![R Version](https://img.shields.io/badge/R-4.4.1-blue)
![Author](https://img.shields.io/badge/Author-T-Saadem-purple)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

---

## Objectif

Le package permet de produire une analyse descriptive complète pour n’importe quel `data.frame` en R.  

Il fournit :

- Statistiques pour les variables numériques : quantiles, moyenne, écart-type  
- Statistiques pour les variables factorielles : fréquences, proportions, mode  
- Traitement minimal pour les autres types de variables  
- Fonction spécifique pour calculs ou transformations adaptées à votre contexte  

Le package inclut le jeu de données `penguins` pour illustrer les exemples et tests.

---

## Fonctions principales

### 1. `analyse_descriptive()`

- **Entrée :** un `data.frame`  
- **Sortie :** un objet de classe `classe` contenant :
  - Types de variables (Numérique, Facteur, Autre)  
  - Nombre total et NA par variable  
  - Statistiques détaillées pour variables numériques et facteurs  
  - Variables non décrites (Autres types)  

> Appelle automatiquement `stat_num()` et `stat_fact()` selon le type de variable.

---

### 2. Fonctions par type de variable

#### a. `stat_num(x)` – Variable numérique

- **Entrée :** un vecteur numérique  
- **Sortie :** objet `classe_a` avec :
  - Nombre total et NA  
  - Quantiles : 0%, 10%, 25%, 50%, 75%, 90%, 100%  
  - Moyenne et écart-type  
  - Observations originales  

**Méthodes S3 :**
- `print.classe_a()` : affiche quantiles, moyenne, écart-type  
- `summary.classe_a()` : résumé complet et formaté  

#### b. `stat_fact(x)` – Variable factorielle

- **Entrée :** un vecteur factor  
- **Sortie :** objet `classe_b` avec :
  - Nombre total et NA  
  - Fréquences et proportions de chaque modalité  
  - Mode  
  - Observations originales  

**Méthodes S3 :**
- `print.classe_b()` : affiche fréquences  
- `summary.classe_b()` : résumé complet avec le mode  

---

### 3. `calcul_specifique()` – Fonction contextuelle

- **Entrée :** un `data.frame` ou une variable  
- **Sortie :** calcul ou transformation spécifique  
- **Méthode S3 associée :** `print()` ou `plot()` selon le type de sortie  

---

## Exemples d’utilisation

```r
library(STTDescriptives)
library(palmerpenguins)

# Analyse complète du jeu de données
res <- analyse_descriptive(penguins)
summary(res)

# Variable numérique
bill_stats <- stat_num(penguins$bill_length_mm)
print(bill_stats)
summary(bill_stats)

# Variable factorielle
species_stats <- stat_fact(penguins$species)
print(species_stats)
summary(species_stats)

# Fonction spécifique
calcul_specifique(penguins)
```
---
# Installation depuis le fichier source
install.packages("STTDescriptives_1.0.tar.gz", repos = NULL, type = "source")
