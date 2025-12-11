#' Methode summary pour statistique numérique
#'
#' Cette methode pour la fonction generique affiche un resume detaille des
#' statistiques d un objet de classe \code{stats_var_num} retourne par la fonction \code{stats_var_num}.
#'
#' @param object Un objet de classe \code{stats_var_num} retourne par la fonction \code{stats_var_num}.
#' @param ... Arguments supplementaires passes a d'autres methodes (non utilises ici).
#'
#' @return Cette methode imprime un resume contenant :
#' \itemize{
#'   \item Le nombre total d'observations et le nombre d'observations manquantes.
#'   \item Les quantiles.
#'   \item La moyenne et l'ecart-type.
#'   }
#' @author Laggoune Yousra, Thierry Fotchou Saadem, Paul Boittiaux
#' @examples
#' sortie_a <- stats_var_num(hyundai$mpg)
#' print(sortie_a)
#' @export



summary.stats_var_num <- function(object, ...) {

  out <- unclass(object)  # Retire la classe de l'objet pour acceder a ses elements bruts
  cat("Variable numerique\n\n")  # Affiche un titre indiquant qu'il s'agit d'une variable numerique

  cat("Nombre d'observations :\n")  # Indique la section sur le nombre d'observations
  for (i in seq_along(out$nombre_observations)) {  # Parcourt les elements du nombre d'observations
    cat(sprintf("%-15s %d \n", names(out$nombre_observations)[i],  # Formate et affiche le nom et la valeur
                out$nombre_observations[i]))  # Affiche la valeur associee au nom de l'observation
  }

  cat("\nQuantiles :\n")  # Indique la section sur les quantiles
  quantile_names <- names(out$quantiles)  # Recupere les noms des quantiles
  for (i in seq_along(out$quantiles)) {  # Parcourt les quantiles
    cat(sprintf("%-10s %f\n", quantile_names[i], out$quantiles[i]))  # Formate et affiche chaque quantile avec son nom et sa valeur
  }

  cat("\nLa moyenne est", round(out$moyenne, 5),  # Affiche la moyenne arrondie a 5 decimales
      "et l'ecart-type est", round(out$ecarttype, 5), "\n")  # Affiche l'ecart-type arrondi a 5 decimales
}




