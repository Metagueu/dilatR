## Fabrication du jeu de donnees `materiaux`
## A executer depuis la racine du projet :  source("data-raw/materiaux.R")
## alpha en K^-1. VALEURS INDICATIVES : a remplacer par des valeurs sourcees
## (Eurocodes, fiches fabricant, tables de reference) avant la soutenance.

materiaux <- data.frame(
  materiau = c("Acier de construction", "Beton", "Aluminium", "Cuivre",
               "Verre sodocalcique", "Invar (Fe-Ni 36 %)", "Bois resineux",
               "Composite carbone/epoxy (UD)"),
  famille  = c("metal", "mineral", "metal", "metal", "mineral", "metal", "bois", "composite"),
  alpha_x  = c(12, 10, 23, 17, 9, 1.2,  5, -0.3) * 1e-6,
  alpha_y  = c(12, 10, 23, 17, 9, 1.2, 35, 28) * 1e-6,
  alpha_z  = c(12, 10, 23, 17, 9, 1.2, 35, 28) * 1e-6,
  source   = c("EN 1993-1-1", "EN 1992-1-1", rep("a verifier (indicatif)", 6)),
  stringsAsFactors = FALSE
)

usethis::use_data(materiaux, overwrite = TRUE)
