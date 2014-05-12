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

test_that("Simple example with more mixed set of values x[1] < y[1] < y[2] < x[2]", {
  x <- c(1, 4)
  y <- c(2, 3)

  dm_x_to_y <- dominance_matrix(x, y)

  expect_equal(dim(dm_x_to_y), c(2, 2))
  expect_equal(sum(dm_x_to_y), 0) # Sum is 0 since two elements are -1 and two are 1

  dm_y_to_x <- dominance_matrix(y, x)

  expect_equal(dim(dm_y_to_x), c(2, 2))
  expect_equal(sum(dm_y_to_x), 0) # Sum is 0 since two elements are -1 and two are 1
})