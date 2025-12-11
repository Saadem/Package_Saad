#' @title Methode summary pour analyse descriptive d'un jeu de donnees
#' @description Cette fonction est la methode S3 pour la fonction d'overview qui permet d'afficher ce que l'on veut en fonction de l'entree
#' @param object Un objet genere par la fonction \code{overview} qui doit etre affiche.
#' @param \dots Arguments supplementaires transmis a dautres methodes.
#' @export
#'
#' @author Laggoune Yousra, Thierry Fotchou Saadem, Paul Boittiaux
#' @examples
#' data(hyundai)
#' object <- overview_df(hyundai)
#' summary(object)


summary.overview_df <- function(object, ...) {

  out <- unclass(object) # Supprime la classe pour un traitement simplifie

  cat("\nType de variable :\n") # Affichage des types de variables
  type_variable_df <- as.data.frame(t(out$type_variable))
  colnames(type_variable_df) <- " "
  print(type_variable_df)

  cat("\nNombre d'observations par variable :\n\n") # Affichage du nombre dobservations et des valeurs manquantes
  nombre_observations_df <- as.data.frame(t(out$nombre_observations))
  print(nombre_observations_df)

  if ("Numerique" %in% out$type_variable) { # Statistiques pour les variables numeriques
    cat("\n*************************************\n")
    cat("Statistiques descrpitives des variables numeriques :\n\n")
    cat("Quantiles par variables :\n\n")
    stat_num_df <- as.data.frame(t(out$stat_num[1:7, ]))
    print(stat_num_df, row.names = TRUE)
    cat("\nMoyenne et variance par variable numerique :\n\n")
    moy_var <- as.data.frame(t(out$stat_num[8:9, ]))
    print(moy_var, row.names = TRUE)
  }
  if ("Facteur" %in% out$type_variable) { # Statistiques pour les variables factorielles
    cat("\n*************************************\n")
        cat("Statistiques descriptives des facteurs :\n\n")
    for (variable in names(out$stat_fact$Frequences)) {

      cat(variable, ": Frequences des categories\n\n")
      print(out$stat_fact$Frequences[[variable]], row.names=FALSE)
      modeOut <- do.call(rbind,out$stat_fact$Mode)
      cat("\n", variable, ": Le mode est", modeOut[variable, 1], "\n\n")
    }
  }

  if ("Autre" %in% out$type_variable) { # Statistiques pour les variables autres
    cat("*************************************\n")
    cat("Les variables qui n'ont pas ete decrites sont :\n ")
    autres <- colnames(out$type_variable)[out$type_variable[1, ] == "Autre"]
    cat(paste(autres, collapse = ", "), "\n")
  }
}



