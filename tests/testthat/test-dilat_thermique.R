test_that("dilat_thermique() : acier, dT = 50 K (exemple 4)", {
  D <- dilat_thermique(12e-6, 50, dim = 3)
  expect_equal(D, diag(rep(1.0006, 3)))
  expect_equal(1000 * (D[1, 1] - 1), 0.6)  # barre de 1 m : +0,6 mm
})

test_that("dilat_thermique() : bois anisotrope, dT = 40 K", {
  D <- dilat_thermique(c(5e-6, 35e-6, 35e-6), 40)
  expect_equal(D, diag(c(1.0002, 1.0014, 1.0014)))
  expect_equal(dilat_resume(D)$det, 1.003002520392)
})

test_that("dilat_thermique() lit les coefficients du jeu de donnees materiaux", {
  alpha <- unlist(materiaux[materiaux$materiau == "Bois resineux",
                            c("alpha_x", "alpha_y", "alpha_z")])
  expect_equal(dilat_thermique(alpha, 40), diag(c(1.0002, 1.0014, 1.0014)))
})

test_that("dilat_thermique() refuse les entrees invalides", {
  expect_error(dilat_thermique(12e-6, "chaud", dim = 3), "dT")
  expect_error(dilat_thermique("a", 50), "alpha")
  expect_error(dilat_thermique(12e-6, -1e6, dim = 3), "strictement positifs")
})
