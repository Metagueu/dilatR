#' Résumé des propriétés d'une matrice de dilatation
#'
#' Calcule le facteur de volume
#' \eqn{\det D = \prod s_i}{det D = prod(s_i)} (facteur d'aire en 2D), les
#' valeurs propres, et le rapport d'anisotropie
#' \eqn{\kappa = s_{max}/s_{min}}{kappa = s_max / s_min}.
#'
#' @param D Matrice de dilatation.
#' @param tol Tolérance relative pour décider si \code{D} est isotrope.
#' @return Une liste nommée :
#'   \itemize{
#'     \item \code{facteurs} : les facteurs \eqn{s_i}{s_i} ;
#'     \item \code{det} : le facteur de volume (ou d'aire) ;
#'     \item \code{variation_pct} : la variation de volume, en pour cent ;
#'     \item \code{valeurs_propres} : les valeurs propres de \code{D} ;
#'     \item \code{anisotropie} : le rapport facteur max / facteur min ;
#'     \item \code{isotrope} : \code{TRUE} si tous les facteurs sont égaux
#'       (à la tolérance près).
#'   }
#' @examples
#' dilat_resume(dilat_matrice(c(3, 0.5)))
#' @export
dilat_resume <- function(D, tol = 1e-10) {
  verifier_D(D)
  s <- unname(diag(D))
  d <- prod(s)  # pour une matrice diagonale, c'est exactement det(D)
  list(
    facteurs        = s,
    det             = d,
    variation_pct   = (d - 1) * 100,
    valeurs_propres = eigen(D, symmetric = TRUE, only.values = TRUE)$values,
    anisotropie     = max(s) / min(s),
    isotrope        = (max(s) - min(s)) <= tol * max(s)
  )
}
