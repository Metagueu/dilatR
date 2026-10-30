#' Appliquer une matrice de dilatation à des points
#'
#' Transforme des points \eqn{\mathbf{x}}{x} en
#' \eqn{\mathbf{x}' = D\,\mathbf{x}}{x' = D x}. Les points sont rangés en
#' lignes : pour une matrice \eqn{X} (un point par ligne), le résultat est
#' \eqn{X' = X\,D^{T}}{X' = X t(D)}.
#'
#' @param D Matrice de dilatation (voir \code{\link{dilat_matrice}}).
#' @param X Matrice m x n (un point par ligne), data.frame numérique, ou
#'   vecteur de longueur n (un seul point).
#' @return Les points transformés, avec la même forme que \code{X}.
#' @examples
#' D <- dilat_matrice(c(3, 0.5))
#' dilat_appliquer(D, rbind(c(2, 4)))   # (6 ; 2)
#' carre <- rbind(c(0, 0), c(1, 0), c(1, 1), c(0, 1))
#' dilat_appliquer(D, carre)            # rectangle 3 x 0,5
#' @export
dilat_appliquer <- function(D, X) {
  verifier_D(D)
  un_seul_point <- is.null(dim(X))
  M <- if (un_seul_point) matrix(X, nrow = 1L) else as.matrix(X)
  if (!is.numeric(M) || anyNA(M) || ncol(M) != nrow(D)) {
    stop("X doit etre numerique, avec autant de colonnes que D (un point par ligne)",
         call. = FALSE)
  }
  # Un point par ligne : (D x)^T = x^T D^T, d'ou M %*% t(D)
  resultat <- M %*% t(D)
  if (un_seul_point) as.vector(resultat) else resultat
}

#' Inverse d'une matrice de dilatation
#'
#' Renvoie \eqn{D^{-1} = \mathrm{diag}(1/s_1, \ldots, 1/s_n)}{D^-1 = diag(1/s_1, ..., 1/s_n)} :
#' la contraction qui ramène à la forme initiale, avec
#' \eqn{D\,D^{-1} = I_n}{D D^-1 = I_n}.
#'
#' @param D Matrice de dilatation.
#' @return La matrice inverse (une matrice de dilatation).
#' @examples
#' dilat_inverse(dilat_matrice(c(2, 4)))
#' @export
dilat_inverse <- function(D) {
  verifier_D(D)
  diag(1 / unname(diag(D)), nrow = nrow(D))
}

#' Composer plusieurs dilatations
#'
#' Calcule le produit de plusieurs matrices de dilatation. Pour deux matrices
#' de facteurs \eqn{s_i}{s_i} et \eqn{t_i}{t_i} :
#' \eqn{D_1 D_2 = \mathrm{diag}(s_1 t_1, \ldots, s_n t_n) = D_2 D_1}{D1 D2 = diag(s_1 t_1, ..., s_n t_n) = D2 D1}.
#' L'ordre est donc sans importance.
#'
#' @param ... Au moins deux matrices de dilatation de même dimension.
#' @return Leur produit (une matrice de dilatation).
#' @examples
#' dilat_composer(dilat_matrice(c(2, 3)), dilat_matrice(c(4, 0.5)))
#' @export
dilat_composer <- function(...) {
  matrices <- list(...)
  if (length(matrices) < 2L) {
    stop("il faut au moins deux matrices de dilatation", call. = FALSE)
  }
  for (i in seq_along(matrices)) {
    verifier_D(matrices[[i]], nom = paste("l'argument", i))
  }
  tailles <- vapply(matrices, nrow, integer(1))
  if (length(unique(tailles)) != 1L) {
    stop("les matrices doivent avoir la meme dimension", call. = FALSE)
  }
  Reduce(`%*%`, matrices)
}
