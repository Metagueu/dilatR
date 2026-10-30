#' Tracer l'effet d'une dilatation 2D
#'
#' Dessine une forme avant (pointillés) et après (trait plein) dilatation.
#' La forme est le carré unité ou le cercle inscrit dans ce carré.
#'
#' @param D Matrice de dilatation 2 x 2.
#' @param forme \code{"carre"} (carré unité) ou \code{"cercle"} (cercle
#'   inscrit dans le carré unité).
#' @param amplif Facteur d'exagération \eqn{a} de la déformation
#'   \eqn{\varepsilon = s - 1}{epsilon = s - 1} : le tracé utilise
#'   \eqn{s^{trace} = 1 + a\,(s - 1)}{s_trace = 1 + a (s - 1)}. Indispensable
#'   en thermique, où \eqn{\varepsilon}{epsilon} vaut environ 0,001 : sans
#'   amplification, les deux formes se superposent. Le facteur est écrit sur
#'   le graphique.
#' @return Un objet \code{ggplot}.
#' @examples
#' dilat_plot(dilat_matrice(c(3, 0.5)), "cercle")
#' dilat_plot(dilat_thermique(c(12e-6, 12e-6), 50), amplif = 500)
#' @export
dilat_plot <- function(D, forme = c("carre", "cercle"), amplif = 1) {
  verifier_D(D)
  if (nrow(D) != 2L) {
    stop("dilat_plot() ne trace que les matrices 2 x 2", call. = FALSE)
  }
  forme <- match.arg(forme)
  if (!is.numeric(amplif) || length(amplif) != 1L || is.na(amplif) || amplif <= 0) {
    stop("amplif doit etre un nombre strictement positif", call. = FALSE)
  }

  # 1. forme de depart
  if (forme == "carre") {
    avant <- rbind(c(0, 0), c(1, 0), c(1, 1), c(0, 1), c(0, 0))
  } else {
    angle <- seq(0, 2 * pi, length.out = 200)
    avant <- cbind(0.5 + 0.5 * cos(angle), 0.5 + 0.5 * sin(angle))
  }

  # 2. amplification de l'ecart a l'identite : s_trace = 1 + amplif * (s - 1)
  D_trace <- dilat_matrice(1 + amplif * (unname(diag(D)) - 1))
  apres <- dilat_appliquer(D_trace, avant)

  # 3. tableau de donnees pour ggplot2
  donnees <- rbind(
    data.frame(x = avant[, 1], y = avant[, 2], etat = "avant"),
    data.frame(x = apres[, 1], y = apres[, 2], etat = "apres")
  )
  donnees$etat <- factor(donnees$etat, levels = c("avant", "apres"))

  sous_titre <- if (amplif == 1) NULL else paste0("Deformation amplifiee x", amplif)

  ggplot2::ggplot(donnees, ggplot2::aes(x = x, y = y, colour = etat, linetype = etat)) +
    ggplot2::geom_path(linewidth = 1) +
    ggplot2::coord_equal() +
    ggplot2::scale_colour_manual(values = c(avant = "grey50", apres = "#0E7C86")) +
    ggplot2::scale_linetype_manual(values = c(avant = "dashed", apres = "solid")) +
    ggplot2::labs(title = "Effet d'une matrice de dilatation", subtitle = sous_titre,
                  x = NULL, y = NULL, colour = NULL, linetype = NULL) +
    ggplot2::theme_minimal()
}
