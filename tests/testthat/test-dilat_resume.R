test_that("dilat_resume() : exemple 2 (anisotrope)", {
  r <- dilat_resume(dilat_matrice(c(3, 0.5)))
  expect_equal(r$facteurs, c(3, 0.5))
  expect_equal(r$det, 1.5)
  expect_equal(r$variation_pct, 50)
  expect_equal(r$valeurs_propres, c(3, 0.5))
  expect_equal(r$anisotropie, 6)
  expect_false(r$isotrope)
})

test_that("dilat_resume() : exemple 1 (isotrope) et cas limites", {
  r <- dilat_resume(dilat_matrice(2, dim = 2))
  expect_equal(r$det, 4)
  expect_equal(r$anisotropie, 1)
  expect_true(r$isotrope)
  expect_true(dilat_resume(dilat_matrice(c(1, 1 + 1e-12)))$isotrope)
  expect_false(dilat_resume(dilat_matrice(c(1, 1 + 1e-6)))$isotrope)
})

test_that("dilat_resume() : exemple 3 (le determinant est le volume du pave)", {
  D3 <- dilat_matrice(c(2, 3, 4))
  cube <- as.matrix(expand.grid(x = 0:1, y = 0:1, z = 0:1))
  cotes <- apply(dilat_appliquer(D3, cube), 2, function(colonne) diff(range(colonne)))
  expect_equal(prod(cotes), dilat_resume(D3)$det)
  expect_equal(dilat_resume(D3)$det, 24)
})

test_that("dilat_resume() : exemple 4 (thermique, acier)", {
  r <- dilat_resume(dilat_thermique(12e-6, 50, dim = 3))
  expect_equal(r$det, 1.0006^3)
  expect_equal(r$variation_pct, 0.1801080216, tolerance = 1e-6)
  expect_lt(abs(r$variation_pct - 0.18), 1e-3)  # premier ordre : 3 alpha dT
})
