#' Dimensionner un joint de dilatation de pont
#'
#' Calcule le mouvement de l'extrémité mobile d'un tablier de longueur
#' \eqn{L_0} et la capacité de joint à prévoir. Seul le facteur de dilatation
#' selon l'axe du tablier (axe x) est utilisé, via
#' \code{\link{dilat_thermique}}.
#' \deqn{C = L_0\,\alpha\,(T_{max} - T_{min})}{C = L0 alpha (T_max - T_min)}
#' \deqn{C_{joint} = C\,(1 + m)}{C_joint = C (1 + m)}
#'
#' @param L0 Longueur dilatable du tablier, en m (de l'appui fixe au joint).
#' @param alpha Coefficient de dilatation linéique, en K^-1 (strictement
#'   positif).
#' @param T_min,T_max Températures extrêmes de calcul, en degrés Celsius.
#' @param T_ref Température de référence (température à la pose), en degrés
#'   Celsius.
#' @param marge Marge de sécurité \eqn{m}{m}, en fraction de la course
#'   (0,2 pour 20 pour cent).
#' @return Une liste : \code{allongement_mm}, \code{raccourcissement_mm},
#'   \code{course_mm} et \code{capacite_mm}.
#' @examples
#' dilat_joint(L0 = 100, alpha = 12e-6, T_min = -10, T_max = 40, T_ref = 10)
#' @export
dilat_joint <- function(L0, alpha, T_min, T_max, T_ref = 20, marge = 0.2) {
  nombres <- list(L0 = L0, alpha = alpha, T_min = T_min, T_max = T_max,
                  T_ref = T_ref, marge = marge)
  for (nom in names(nombres)) {
    v <- nombres[[nom]]
    if (!is.numeric(v) || length(v) != 1L || is.na(v)) {
      stop(nom, " doit etre un nombre", call. = FALSE)
    }
  }
  if (L0 <= 0) {
    stop("L0 doit etre une longueur strictement positive (en m)", call. = FALSE)
  }
  if (alpha <= 0) {
    stop("alpha doit etre strictement positif (en K^-1) pour dimensionner un joint",
         call. = FALSE)
  }
  if (T_min >= T_max) {
    stop("T_min doit etre inferieure a T_max", call. = FALSE)
  }
  if (marge < 0) {
    stop("marge doit etre positive ou nulle", call. = FALSE)
  }
  if (T_ref < T_min || T_ref > T_max) {
    warning("T_ref est en dehors de [T_min, T_max] : interpreter allongement et ",
            "raccourcissement avec precaution", call. = FALSE)
  }

  # facteur de dilatation selon l'axe du tablier, a chaud puis a froid
  s_chaud <- dilat_thermique(alpha, T_max - T_ref, dim = 1)[1, 1]
  s_froid <- dilat_thermique(alpha, T_min - T_ref, dim = 1)[1, 1]

  allongement      <- L0 * (s_chaud - 1) * 1000   # en mm
  raccourcissement <- L0 * (s_froid - 1) * 1000   # en mm (negatif si T_min < T_ref)
  course           <- allongement - raccourcissement

  list(allongement_mm      = allongement,
       raccourcissement_mm = raccourcissement,
       course_mm           = course,
       capacite_mm         = course * (1 + marge))
}
