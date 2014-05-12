context("Cliff's d statistic")

test_that("Example from page 2&3 of Hogarthy and Kromrey's paper works", {
  control <- c(1, 1, 2, 2, 2, 3, 3, 3, 4, 5)
  exp <- c(1, 2, 3, 4, 4, 5)

  d <- calc.cliffs.d(control, exp)
  expect_equal(d, -0.25)

  vd <- consistent.estimate.cliffs.d.variance(control, exp)
  expect_equal(signif(vd, 3), 0.106)

  interval <- confidence.interval.for.cliffs.d(d, vd, 0.05)
  expect_equal(signif(interval[1], 3), -0.713)
  expect_equal(signif(interval[2], 3), 0.364)
})
