context("Vargha Delaney A statistic (stochastic superiority)")

test_that("Example from page 106 of Vargha and Delaney's paper works", {
  x <- rep(1:3, c(1, 6, 3))
  y <- rep(1:3, c(3, 6, 1))

  x_to_y <- a.statistic(x, y)
  y_to_x <- a.statistic(y, x)

  expect_equal(x_to_y$a, 0.66)
  expect_equal(y_to_x$a, 0.34)

  expect_equal(x_to_y$interpretation, "Medium")
  expect_equal(y_to_x$interpretation, "Medium")
})
