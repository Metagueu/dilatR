test_that("materiaux : structure et valeurs de reference", {
  expect_s3_class(materiaux, "data.frame")
  expect_equal(dim(materiaux), c(8L, 6L))
  expect_named(materiaux, c("materiau", "famille", "alpha_x", "alpha_y", "alpha_z", "source"))
  expect_equal(materiaux$alpha_x[materiaux$materiau == "Acier de construction"], 12e-6)
  expect_true(all(materiaux$alpha_y > 0))
  expect_lt(min(materiaux$alpha_x), 0)  # composite carbone/epoxy : alpha_x negatif
})
