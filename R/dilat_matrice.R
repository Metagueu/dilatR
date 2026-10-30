#' Construire une matrice de dilatation
#'
#' Construit la matrice diagonale
#' \eqn{D = \mathrm{diag}(s_1, \ldots, s_n)}{D = diag(s_1, ..., s_n)},
#' qui multiplie l'axe \eqn{i}{i} par le facteur \eqn{s_i}{s_i}.
#' Si un seul facteur est donné, la dilatation est isotrope :
#' \eqn{D = s\,I_n}{D = s I_n}.
#'
#' @param s Facteurs de dilatation, strictement positifs : un vecteur (un
#'   facteur par axe) ou un seul nombre (dilatation isotrope, avec
#'   \code{dim}).
#' @param dim Dimension de la matrice (2 pour le plan, 3 pour l'espace).
#'   Par défaut \code{length(s)}.
#' @return Une matrice carrée \code{dim} x \code{dim}, diagonale.
#' @seealso \code{\link{dilat_thermique}} pour construire la matrice à partir
#'   de coefficients de dilatation thermique.
#' @examples
#' dilat_matrice(2, dim = 2)   # isotrope : D = 2 I
#' dilat_matrice(c(3, 0.5))    # anisotrope
#' @export
dilat_matrice <- function(s, dim = length(s)) {
  force(dim)  # evalue la valeur par defaut maintenant, avant toute modification de s
  if (!is.numeric(s) || length(s) < 1L || anyNA(s)) {
    stop("s doit etre un vecteur numerique, sans valeur manquante", call. = FALSE)
  }
  if (any(s <= 0)) {
    stop("les facteurs de dilatation doivent etre strictement positifs", call. = FALSE)
  }
  if (!is.numeric(dim) || length(dim) != 1L || is.na(dim) || dim < 1 || dim != round(dim)) {
    stop("dim doit etre un entier positif", call. = FALSE)
  }
  s <- unname(s)  # une matrice sans noms de lignes ni de colonnes parasites
  if (length(s) == 1L) {
    s <- rep(s, dim)
  } else if (length(s) != dim) {
    stop("s doit contenir `dim` facteurs (ou un seul facteur pour le cas isotrope)",
         call. = FALSE)
  }
  diag(s, nrow = length(s))
}

#' Construire une matrice de dilatation thermique
#'
#' Construit \eqn{D = \mathrm{diag}(1 + \alpha_i\,\Delta T)}{D = diag(1 + alpha_i dT)}
#' à partir de la loi de dilatation linéique
#' \eqn{L = L_0\,(1 + \alpha\,\Delta T)}{L = L0 (1 + alpha dT)}.
#' Chaque axe peut avoir son propre coefficient (matériaux anisotropes :
#' bois, composites).
#'
#' @param alpha Coefficient(s) de dilatation linéique, en K^-1 : un par axe,
#'   ou un seul avec \code{dim}. Exemple : \code{12e-6} pour l'acier.
#' @param dT Écart de température en K, \eqn{\Delta T = T - T_{ref}}{dT = T - T_ref}.
#' @param dim Dimension de la matrice. Par défaut \code{length(alpha)}.
#' @return Une matrice carrée diagonale.
#' @seealso \code{\link{dilat_matrice}}, \code{\link{dilat_joint}}
#' @examples
#' dilat_thermique(12e-6, 50, dim = 3)          # acier, isotrope
#' dilat_thermique(c(5e-6, 35e-6, 35e-6), 40)   # bois, anisotrope
#' @export
dilat_thermique <- function(alpha, dT, dim = length(alpha)) {
  force(dim)
  if (!is.numeric(alpha) || length(alpha) < 1L || anyNA(alpha)) {
    stop("alpha doit etre numerique (en K^-1, par exemple 12e-6)", call. = FALSE)
  }
  if (!is.numeric(dT) || length(dT) != 1L || is.na(dT)) {
    stop("dT doit etre un nombre (ecart de temperature en K)", call. = FALSE)
  }
  dilat_matrice(1 + alpha * dT, dim = dim)
}
