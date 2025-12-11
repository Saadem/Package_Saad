#' @title Methode print pour statistiques numérique
#'
#' @description Cette methode pour la fonction generique print affiche un resume des statistiques
#' calculees par la fonction stats_var_num
#'
#' @param x Un objet de classe stats_var_num retourne par la fonction stats_var_num
#' @param ... Arguments supplementaires passes a la fonction print
#'
#' @return Cette methode imprime un extrait de l'objet contenant:
#'
#' \itemize{
#'   \item Les quantiles
#'   \item La moyenne
#'   \item L'ecart-type   }
#'
#' @author Laggoune Yousra, Thierry Fotchou Saadem, Paul Boittiaux
#' @examples
#' data(hyundai)
#' sortie_a <- stats_var_num(hyundai$mpg)
#' print(sortie_a)
#' @export


print.stats_var_num<- function(x,...){

    stats<- c(x$quantiles, "Moyenne" = x$moyenne ,"E.T" = x$ecarttype )

    print(round(stats,6), ...) # Affichage des quantiles,la moyenne et l'ecart-type

    invisible(x)
}



