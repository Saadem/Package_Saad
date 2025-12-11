#' Statistiques pour une variable numerique
#'
#' La fonction \code{stats_num} sert a calculer des statistiques decrivant les observations d'une variable numerique.
#'
#' @param vect_num Un vecteur numerique contenant les observations de la variable a traiter.
#' @param ... Argument supplementaires
#'
#' @return Une liste de cinq éléments :
#' \itemize{
#'   \item \strong{nombre_observations} : Un vecteur nommé contenant deux valeurs :
#'   \item \strong{quantiles} : Un vecteur contenant les quantiles suivants :
#'     0%, 10%, 25%, 50%, 75%, 90%, 100%.
#'   \item \strong{moyenne} : La moyenne des observations.
#'   \item \strong{ecarttype} : L'ecart-type des observations.
#'   \item \strong{observations} : Un vecteur numérique contenant les valeurs des observations,
#'     y compris les observations manquantes.
#' }
#' @author Laggoune Yousra, Thierry Fotchou Saadem, Paul Boittiaux
#' @examples
#' data(hyundai)
#' sortie_a <- stats_var_num(hyundai$mpg)
#' str(sortie_a)


stats_var_num <- function(vect_num, ...) {


  if(!is.vector(vect_num, mode = "numeric")) # Verification du type de l'argument
    stop("L'argument fournie n'est pas de type Numerique") # Si le vecteur n'est pas numerique, une erreur est generee.

  out_stats_num <- list() # Initialisation d'une liste pour stocker les resultats
  out_stats_num$nombre_observations <- c("Total :" = length(vect_num), # Initialisation du nombre total d'observations
                                         "Manquantes (NA) :" = sum(is.na(vect_num))) #et des valeurs manquantes

  out_stats_num$quantiles <- quantile(vect_num,
                                      probs = c(0, .1, .25, .5, .75, .9, 1),
                                      na.rm =TRUE,
                                      digits = 3) # Calcul des quantiles

  out_stats_num$moyenne <- mean(vect_num, na.rm = TRUE) # Calcul de la moyenne

  out_stats_num$ecarttype <- sd(vect_num, na.rm = TRUE) # Calcul de l'ecart type

  out_stats_num$observations <- vect_num

  class(out_stats_num) <- "stats_var_num" # Definition de la classe de l'objet de sortie

  return(out_stats_num) # Retourne la liste contenant toutes les statistiques calculees

}


