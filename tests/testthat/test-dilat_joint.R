test_that("dilat_joint() : pont de 100 m, acier, -10 a 40 C, T_ref = 10 C", {
  j <- dilat_joint(L0 = 100, alpha = 12e-6, T_min = -10, T_max = 40, T_ref = 10)
  expect_equal(j$allongement_mm, 36)
  expect_equal(j$raccourcissement_mm, -24)
  expect_equal(j$course_mm, 60)
  expect_equal(j$capacite_mm, 72)
  expect_equal(j$course_mm, 100 * 12e-6 * 50 * 1000)  # C = L0 alpha (Tmax - Tmin)
})

test_that("dilat_joint() : beton", {
  j <- dilat_joint(100, 10e-6, -10, 40, T_ref = 10)
  expect_equal(j$course_mm, 50)
  expect_equal(j$capacite_mm, 60)
})

test_that("dilat_joint() refuse les entrees invalides et signale T_ref hors plage", {
  expect_error(dilat_joint(100, 12e-6, 40, -10), "T_min")
  expect_error(dilat_joint(100, -1e-6, -10, 40), "alpha")
  expect_error(dilat_joint(-5, 12e-6, -10, 40), "L0")
  expect_error(dilat_joint(100, 12e-6, -10, 40, marge = -1), "marge")
  expect_warning(dilat_joint(100, 12e-6, -10, 40, T_ref = 60), "T_ref")
})
