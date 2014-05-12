context("Dominance matrix")

test_that("Simple example where all elements of one set is larger than all in another", {
  x <- c(1, 2, 3)
  y <- c(4, 5)

  dm_x_to_y <- dominance_matrix(x, y)

  expect_equal(dim(dm_x_to_y), c(3, 2))
  expect_equal(sum(dm_x_to_y), -6) # Sum is -6 since all elements should be -1

  dm_y_to_x <- dominance_matrix(y, x)

  expect_equal(dim(dm_y_to_x), c(2, 3))
  expect_equal(sum(dm_y_to_x), 6) # Sum is 6 since all elements should be 1
})