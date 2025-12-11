#' @title Analyse descriptive d'un jeu de donnes
#' @description  realise une analyse descriptive d'un jeu de donnee.
#' @param donnee Un data frame.
#' @return une liste de 5 elements
#' \itemize{
#'
#'   \item \strong{type_variable} : Une matrice qui indique le type de chaque variable du jeu de données (en colonnes). Les types possibles sont :
#'   \itemize{
#'     \item \emph{Numerique} : Variables quantitatives.
#'     \item \emph{Facteur} : Variables qualitatives categoriques.
#'     \item \emph{Autre} : Variables ne correspondant pas aux types precedents.
#'   }
#'   \item \strong{nombre_observations} : Une matrice qui contient, pour chaque variable du jeu de données (en colonnes), les informations suivantes :
#'   \itemize{
#'     \item Colonne 1 : Le nombre total d'observations disponibles.
#'     \item Colonne 2 : Le nombre d'observations manquantes.
#'   }
#'
#'   \item \strong{stat_num} : Une matrice contenant les statistiques descriptives des variables numériques du jeu de données (en colonnes). Les statistiques sont presentees en lignes :
#'   \itemize{
#'     \item Quantiles empiriques : 0 %, 10 %, 25 %, 50 %, 75 %, 90 %, et 100 %.
#'     \item Moyenne : La moyenne des valeurs.
#'     \item Écart-type : La dispersion des valeurs autour de la moyenne.
#'   }
#'
#'   \item \strong{stat_fact} : Une liste composée de deux elements decrivant les variables de type facteur :
#'   \itemize{
#'     \item \strong{Frequences} : Une liste contenant, pour chaque variable de type facteur, un \code{data.frame} des frequences obtenu via la fonction \code{stat_factor}.
#'     \item \strong{Mode} : Une liste nommee contenant, pour chaque variable de type facteur, le mode calcule via la fonction \code{stat_factor}.
#'   }
#'
#'   \item \strong{var_autre} : Un vecteur contenant les noms des variables classees comme \emph{Autre}.
#' }

#' @author Laggoune Yousra, Thierry Fotchou Saadem, Paul Boittiaux
#' @export
#' @examples
#' data(hyundai)
#' out_overview <- overview_df(hyundai)
#' str(out_overview)



overview_df <- function(donnee) {
  if (!is.data.frame(donnee) && !is.table(donnee)) # Verification
    stop("L'argument fourni n'est pas un data frame")

  if(is.table(donnee))
    donnee <- as.data.frame(donnee) # Si cest un tableau, on le convertit en data frame


  nombre_observations <- matrix(nrow = 2, ncol = ncol(donnee), # Initialisation des matrices pour les observations
                                dimnames = list(c("Total :", "Manquantes (NA) :"),
                                                colnames(donnee)
                                )
  )

  type_variable <- matrix(nrow = 1, ncol = ncol(donnee), dimnames = list(NULL, # Initialisation des matrices pour les types de variables
                                                                         colnames(donnee)
  )
  )



  nbre_var_num <- sum(sapply(donnee, "is.numeric")) # Calcul du nombre de variables numeriques

  noms_var_num <- colnames(donnee[ , sapply(donnee, "is.numeric")]) # Creation de la matrice pour les statistiques des variables numeriques
  stat_num <- matrix(nrow = 9, ncol = sum(sapply(donnee, "is.numeric")))

  rownames(stat_num)=c("0%", "10%", "25%", "50%", "75%", "90%", "100%", "Moyenne", "E.T")
  colnames(stat_num)=noms_var_num

  stat_fact <- list(Frequences = list(), Mode = list()) # Liste pour stocker les statistiques des variables factorielles

  var_autre <- character()  # Vecteur pour les variables autres

  for (variable in names(donnee)) { # traitement de chaque variable
    total <- length(donnee[[variable]]) # Nombre total d'observations
    total_manquant <- sum(is.na(donnee[[variable]])) # Nombre d'observations manquantes
    nombre_observations[ , variable] <- c(total, total_manquant)


    if (is.numeric(donnee[[variable]])) { # Traitement des variables numeriques
      type_variable[ , variable] <- "Numerique"
      stats_n <- stats_var_num(donnee[[variable]]) # statistiques des variables numeriques
      stat_num[ , variable] <- c(stats_n$quantiles, stats_n$moyenne, stats_n$ecarttype)
    } else if (is.factor(donnee[[variable]])) { # Traitement des variables factorielles
      type_variable[ , variable] <- "Facteur"
      stats_f <- stats_fact(donnee[[variable]]) # statistiques des variables factorielles
      stat_fact$Frequences[[variable]] <- stats_f$frequences
      stat_fact$Mode[[variable]] <- stats_f$Mode
    } else { # Traitement des autres variables
      type_variable[ , variable] <- "Autre"
      var_autre <- c(var_autre, variable)
    }
  }

  out_overview <- list(nombre_observations = nombre_observations,  # Creation de la liste de sortie
                       type_variable = type_variable,
                       stat_num = stat_num,
                       stat_fact = stat_fact,
                       var_autre = var_autre)

  class(out_overview) <- "overview_df"   # Attribution de la classe "overview_df" a la sortie

  return(out_overview) #retourne une analyse descriptive
}


