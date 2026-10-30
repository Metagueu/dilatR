#' Contrôle interne d'une matrice de dilatation
#'
#' Vérifie que \code{D} est une matrice numérique carrée, diagonale, à
#' diagonale strictement positive. Déclenche une erreur sinon.
#'
#' @param D Objet à vérifier.
#' @param nom Nom à afficher dans le message d'erreur.
#' @return \code{TRUE}, de façon invisible.
#' @noRd
verifier_D <- function(D, nom = "D") {
  if (!is.matrix(D) || !is.numeric(D) || anyNA(D)) {
    stop(nom, " doit etre une matrice numerique, sans valeur manquante", call. = FALSE)
  }
  if (nrow(D) != ncol(D)) {
    stop(nom, " doit etre carree", call. = FALSE)
  }
  hors_diagonale <- D[row(D) != col(D)]
  if (any(abs(hors_diagonale) > 1e-12)) {
    stop(nom, " doit etre diagonale", call. = FALSE)
  }
  if (any(diag(D) <= 0)) {
    stop("les facteurs de dilatation (diagonale de ", nom, ") doivent etre strictement positifs",
         call. = FALSE)
  }
  invisible(TRUE)
}
