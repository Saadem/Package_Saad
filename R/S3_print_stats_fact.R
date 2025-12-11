#' @title Methode print pour statistique de variable categorique
#'
#' @description Cette methode pour la fonction generique print affiche un resume detaille des statistiques calculees par la fonction stats_fact.
#'
#' @param x Un objet de classe stats_fact retourne par la fonction stats_fact.
#' @param ... Arguments supplementaires
#'
#' @return Cette methode imprime :
#' \itemize{
#'   \item Un tableau des frequences (modalites, frequences absolues, proportions).
#'  }
#'
#' @author Laggoune Yousra, Thierry Fotchou Saadem, Paul Boittiaux
#' @examples
#' data(hyundai)
#' sortie_b <- stats_fact(hyundai$model)
#' print(sortie_b)
#' @export

print.stats_fact <- function(x,...){

  print(x$frequences,row.names = FALSE) # Affichage des frequences sans afficher les noms de lignes
  invisible(x)

}















