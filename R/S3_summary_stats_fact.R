#' @title Methode summary pour statistique de variable categorique
#'
#' @description Cette methode pour la fonction generique summary affiche un resume des statistiques
#' calculees par la fonction stats_fact
#'
#' @param object Un objet de classe stats_fact retourne par la fonction stats_fact.
#' @param ... Arguments supplementaires
#'
#' @return Cette methode affiche:
#' \itemize{
#'   \item Le nombre total d'observations et les observations manquantes.
#'   \item Un tableau des frequences (modalites et frequences absolues).
#'   \item Le mode (la categorie la plus frequente).
#'}
#' @author Laggoune Yousra, Thierry Fotchou Saadem, Paul Boittiaux
#' @examples
#' data(hyundai)
#' sortie_b <- stats_fact(hyundai$model)
#' summary(sortie_b)
#' @export

summary.stats_fact <- function(object, ...) {

  out <- unclass(object) # Convertir l'objet en sa forme non classee pour manipulation directe.

  cat("Variable categorique \n\n") # Affichage d'une description generale de la variable categorique.

  cat("Nombre d'observations :\n")

  for (i in seq_along(out$nombre_observations)) { # Affichage du nombre total d'observations pour chaque categorie.

    cat(sprintf("%-15s %d \n", names(out$nombre_observations)[i], out$nombre_observations[i]))

  }

  cat("\n") # Saut de ligne

  cat("Frequences :\n") # Affichage des frequences des differentes categories.

  print(out$frequences, row.names = FALSE) # Afficher le tableau des frequences sans afficher les noms de lignes.

  cat("\n") # Saut de ligne

  cat("Le mode est la categorie ", out$Mode) # Affichage du mode
}




