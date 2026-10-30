test_that("dilat_plot() renvoie un objet ggplot", {
  D <- dilat_matrice(c(3, 0.5))
  expect_true(inherits(dilat_plot(D), "ggplot"))
  expect_true(inherits(dilat_plot(D, "cercle"), "ggplot"))
  expect_true(inherits(dilat_plot(dilat_thermique(c(12e-6, 12e-6), 50), amplif = 500),
                       "ggplot"))
})

test_that("dilat_plot() refuse les entrees invalides", {
  expect_error(dilat_plot(diag(3)), "2 x 2")
  expect_error(dilat_plot(dilat_matrice(c(3, 0.5)), amplif = -1), "amplif")
  expect_error(dilat_plot(dilat_matrice(c(3, 0.5)), forme = "triangle"))
})
