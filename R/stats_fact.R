#' @title Statistique pour variable categorique
#'
#' @description La fonction \code{stats_fact} sert a decrire les observations d'une variable categorielle. Elle calcule les statistiques de base, y compris les frequences, les proportions et le mode.
#'
#' @param vect_fact Un vecteur contenant les observations de la variable a traiter.
#' @param ... Arguments supplementaires
#'
#' @return Une liste de cinq elements :
#' \itemize{
#'   \item \strong{nombre_observations} : Un vecteur contenant deux valeurs :
#'     \itemize{
#'       \item Le nombre total d'observations.
#'       \item Le nombre d'observations manquantes (NA).
#'     }
#'   \item \strong{frequences} : Un data frame contenant :
#'     \itemize{
#'       \item \strong{Modalite} : Les modalites de la variable (excluant les valeurs manquantes).
#'       \item \strong{Frequence} : Les frequences des modalites.
#'       \item \strong{Proportion} : Les proportions relatives des modalites.
#'     }
#'   \item \strong{mode} : Le mode de la variable (la modalite la plus frequente).
#'   \item \strong{observations} : Une copie du vecteur d'observations fourni.
#' }
#' @author Laggoune Yousra, Thierry Fotchou Saadem, Paul Boittiaux
#' @examples
#' sortie_b <- stats_fact(hyundai$model)
#' str(sortie_b)
#' @export

stats_fact <- function(vect_fact, ...) {
  if (!is.factor(vect_fact)) # Verifie si l'argument fourni est de type facteur
    stop("L'argument fourni n'est pas de type facteur.")

  out_stats_fact <- list() # Initialise une liste vide pour stocker les resultats

  out_stats_fact$nombre_observations <- c("Total :" = length(vect_fact), # Calcule le nombre total d'observations
                                          "Manquantes (NA) :" = sum(is.na(vect_fact))) # et le nombre de valeurs manquantes (NA)

  vect_factor <- vect_fact[!is.na(vect_fact)]
  table_fact <- table(vect_factor)
  out_stats_fact$frequences <- data.frame("Modalite" = levels(vect_factor), # Calcule les frequences absolues, les proportions et les organise dans une table
                                          "Frequence" = as.integer(table_fact),
                                          "Proportion" = prop.table(as.numeric(table_fact)
                                          )
  )

  out_stats_fact$Mode <- which.max(table_fact) # Identifie la modalite avec la frequence la plus elevee

  out_stats_fact$observations <- vect_fact

  class(out_stats_fact) <- "stats_fact" # Assigne une classe specifique "stats_fact" a l'objet retourne

  return(out_stats_fact)

}



