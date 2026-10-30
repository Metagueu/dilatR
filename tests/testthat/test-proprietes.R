test_that("proprietes algebriques sur 50 matrices tirees au hasard", {
  set.seed(2026)
  for (i in 1:50) {
    n <- sample(2:4, 1)
    A <- dilat_matrice(runif(n, 0.5, 2))
    B <- dilat_matrice(runif(n, 0.5, 2))
    X <- matrix(rnorm(5 * n), nrow = 5)
    # det(AB) = det(A) det(B)
    expect_equal(dilat_resume(dilat_composer(A, B))$det,
                 dilat_resume(A)$det * dilat_resume(B)$det)
    # A A^-1 = I
    expect_equal(A %*% dilat_inverse(A), diag(n))
    # aller-retour : A^-1 (A X) = X
    expect_equal(dilat_appliquer(dilat_inverse(A), dilat_appliquer(A, X)), X)
  }
})
