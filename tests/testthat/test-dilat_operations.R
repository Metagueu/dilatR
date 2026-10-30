test_that("dilat_appliquer() : exemples 1 et 2", {
  carre <- rbind(c(0, 0), c(1, 0), c(1, 1), c(0, 1))
  D1 <- dilat_matrice(2, dim = 2)
  expect_equal(dilat_appliquer(D1, c(1, 1)), c(2, 2))
  expect_equal(dilat_appliquer(D1, carre),
               rbind(c(0, 0), c(2, 0), c(2, 2), c(0, 2)))
  D2 <- dilat_matrice(c(3, 0.5))
  expect_equal(dilat_appliquer(D2, rbind(c(2, 4))), rbind(c(6, 2)))
  expect_equal(dilat_appliquer(D2, carre),
               rbind(c(0, 0), c(3, 0), c(3, 0.5), c(0, 0.5)))
})

test_that("dilat_appliquer() : exemple 3 (cube -> pave 2 x 3 x 4) et data.frame", {
  D3 <- dilat_matrice(c(2, 3, 4))
  cube <- as.matrix(expand.grid(x = 0:1, y = 0:1, z = 0:1))
  cotes <- apply(dilat_appliquer(D3, cube), 2, function(colonne) diff(range(colonne)))
  expect_equal(unname(cotes), c(2, 3, 4))
  X <- data.frame(x = c(1, 2), y = c(1, 2))
  expect_equal(dilat_appliquer(dilat_matrice(c(3, 0.5)), X),
               rbind(c(3, 0.5), c(6, 1)))
})

test_that("dilat_appliquer() refuse les entrees invalides", {
  D2 <- dilat_matrice(c(3, 0.5))
  expect_error(dilat_appliquer(D2, c(1, 2, 3)), "colonnes")
  expect_error(dilat_appliquer(matrix(c(1, 1, 0, 1), nrow = 2), c(1, 1)), "diagonale")
})

test_that("dilat_inverse() : D^-1 et D D^-1 = I", {
  D3 <- dilat_matrice(c(2, 3, 4))
  expect_equal(dilat_inverse(dilat_matrice(c(2, 4))), diag(c(0.5, 0.25)))
  expect_equal(dilat_inverse(D3), diag(c(1 / 2, 1 / 3, 1 / 4)))
  expect_equal(D3 %*% dilat_inverse(D3), diag(3))
  expect_equal(dilat_inverse(dilat_inverse(D3)), D3)
})

test_that("dilat_composer() : produit de dilatations", {
  Da <- dilat_matrice(c(2, 3))
  Db <- dilat_matrice(c(4, 0.5))
  expect_equal(dilat_composer(Da, Db), diag(c(8, 1.5)))
  expect_equal(dilat_composer(Da, Db), dilat_composer(Db, Da))
  expect_equal(dilat_resume(dilat_composer(Da, Db))$det, 12)
  expect_equal(dilat_composer(Da, Db, Da), diag(c(16, 4.5)))
})

test_that("dilat_composer() refuse les entrees invalides", {
  Da <- dilat_matrice(c(2, 3))
  expect_error(dilat_composer(Da), "au moins deux")
  expect_error(dilat_composer(Da, dilat_matrice(c(1, 2, 3))), "meme dimension")
})
