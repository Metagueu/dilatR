test_that("dilat_matrice() construit D = diag(s)", {
  expect_equal(dilat_matrice(2, dim = 2), matrix(c(2, 0, 0, 2), nrow = 2))
  expect_equal(dilat_matrice(c(3, 0.5)), diag(c(3, 0.5)))
  expect_equal(dilat_matrice(1.5, dim = 3), diag(rep(1.5, 3)))
  expect_equal(dilat_matrice(c(a = 2, b = 3)), diag(c(2, 3)))  # les noms sont retires
})

test_that("dilat_matrice() refuse les entrees invalides", {
  expect_error(dilat_matrice(c(1, -2)), "strictement positifs")
  expect_error(dilat_matrice(c(1, 0)), "strictement positifs")
  expect_error(dilat_matrice(c(1, 2, 3), dim = 2), "dim")
  expect_error(dilat_matrice("a"), "numerique")
  expect_error(dilat_matrice(c(1, NA)), "numerique")
  expect_error(dilat_matrice(2, dim = 0), "entier positif")
})
