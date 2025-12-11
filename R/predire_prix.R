#' @title Prediction du prix
#'
#' @description Prediction du prix d'un vehicule Hyundai d'occasion selon ses caracteristiques.
#'
#'
#'
#'
#' @param year Annee de construction du vehicule. Prediction plus precise pour les vehicules produits apres 2000.
#' @param mileage Kilometrage du vehicule, avec un maximum recommande de 250 000km.
#' @param transmission Type de transmission, au choix parmi "Automatic", "Semi-Auto" et "Manual".
#' @param model Modele du vehicule parmi les modeles suivants:"I20","Tucson","I10","IX35","I30","I40","Ioniq", "Kona","Veloster","I800","IX20","Santa Fe","Accent","Terracan","Getz","Amica".
#' @param fuelType Type de carburant, au choix entre "Diesel", "Hybrid", "Petrol" ou "Other".
#' @param mpg Consommation du vehicule.
#' @param engineSize Taille du moteur du vehicule.
#' @param data Dataset contenant les informations pour entrainer le modele
#'
#' @author Laggoune Yousra, Thierry Fotchou Saadem, Paul Boittiaux
#' @return \code{"prix_estime"}: un objet de classe "prix_estime" qui represente le prix estime par le modele
#' @importFrom stats lm predict
#'
#'
#' @examples
#' data(hyundai)
#' prix_prediction <- predire_prix(year=2020,mileage=10000,
#'                      transmission="Manual",model="I20",fuelType ="Hybrid",
#'                      mpg=45,engineSize=1.8,data=hyundai)
#' print(prix_prediction)
#' @export
predire_prix <- function(year, mileage, transmission, model, fuelType, mpg, engineSize, data) {


  if (!is.numeric(year)) {
    stop("L'annee doit etre une valeur numerique")
  }

  if (!is.numeric(mileage)) {
    stop("Le kilometrage doit etre une valeur numerique")
  }

  if (!is.numeric(engineSize)) {
    stop("La taille du moteur doit etre une valeur numerique")
  }

  if (!is.numeric(mpg)) {
    stop("La consommation doit etre une valeur numerique")
  }

  if (!(transmission %in% c('Automatic', "Semi-Auto", "Manual"))) {
    stop("La tansmission doit etre une des valeurs permise parmi: Automatic, Semi-Auto ou Manual")

  }

  if (!(fuelType %in% c('Hybrid', "Petrol", "Diesel"))) {
    stop("Le type de carburant doit etre une des valeurs permise parmi: Petrol, Diesel, Hybrid ou Other")

  }

  if (!(model %in% c("I20", "Tucson", "I10", "IX35", "I30", "I40","Ioniq", "Kona", "Veloster", "I800", "IX20", "Santa Fe", "Accent","Terracan",
                     "Getz", "Amica"))) {
    stop("Le model doit etre un des suivants:  I20, Tucson, I10, IX35, I30, I40,Ioniq, Kona, Veloster, I800, IX20, Santa Fe,
         Accent,Terracan, Getz ou Amica")

  }

  modele_prediction <- lm(price ~ year + mileage + transmission + model + fuelType + mpg + engineSize, data = data)
  vehicule <- data.frame(year = year,
                         mileage = mileage,
                         transmission = factor(transmission, levels = levels(data$transmission)),
                         model = factor(model, levels = levels(data$model)),
                         fuelType = factor(fuelType, levels = levels(data$fuelType)),
                         mpg = mpg,
                         engineSize = engineSize)


  prix_prediction <- predict(modele_prediction, newdata = vehicule)
  if (prix_prediction < 0) {
    stop("Nous n'avons pas de vehicules avec ces carateristiques dans nos base de donnees, veuillez essayer avec d'autres caracteristiques")

  }
  class(prix_prediction) <- "prix_estime"
  return(prix_prediction)
}


#' Prediction du prix
#'
#' @description
#' Cette fonction predit le prix d'un vehicule base sur divers parametres.
#'
#'
#'
#' @describeIn predire_prix Affiche un objet de la classe \code{"prix_estime"}.
#' @param x Un objet produit par la fonction \code{predire_prix}, a afficher
#' @param \dots D'autres arguments passes a d'autre methodes
#'
#'
#'
#' @examples
#' print(prix_prediction)
#'
#' @export
print.prix_estime <- function(x, ...) {
  cat("Le prix estime du vehicule est de : ", round(x, 2), " CAD.\n")
}




#' Hyundai dataset
#'
#' Un dataset comprenant des observations a propos de vehicules Hyundai d'occasion
#'
#' @format A data frame with 4860 rows and 9 variables:
#' \describe{
#'   \item{model}{modele du vehicule}
#'   \item{year}{annee de fabrication}
#'   \item{price}{prix du vehicule}
#'   \item{mileage}{Kilometrage}
#'   \item{mpg}{Consommation}
#'   \item{fuelType}{Type de carburant}
#'   \item{engineSize}{Taille du moteur}
#'   \item{transmission}{Mode de transmisison du vehicule}
#'   \item{tax...}{Taxe}
#' }
#' @source \url{https://www.kaggle.com/datasets/mysarahmadbhat/hyundai-used-car-listing}
#' @examples
#' data(hyundai)
#'
"hyundai"
