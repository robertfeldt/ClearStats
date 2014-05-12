#
# Cliff's d non-parametric effect size.
# Copyright (c) Robert Feldt, 2010-2014
# robert.feldt@gmail.com
# 
# Incorporated into ClearStats 2014-05-12 based on nonparametric_effect_sizes.R
#

# Cliff's d value is simply the average value of the dominance
# matrix. This value is between -1 and 1. The Vargha and Delanye
# paper calls this value stochastic difference since it corresponds
# to P(X1 > X2) - P(X2 < X1).
calc.cliffs.d = function(sample1, sample2) {
  # Get the dominance matrix
  dm <- dominance_matrix(sample1, sample2);

  # Flatten the matrix
  dim(dm) <- NULL;

  # and calulcate its mean value => cliffs.d
  cliffsd <- mean(dm);
  cliffsd
}

# The "consistent" estimate of Cliff's d variance as described in
#
#  Kristine Y. Hogarty and Jeffrey D. Kromrey
#  "Using SAS to Calculate Tests of Cliff’s Delta"
#  Department of Educational Measurement and Research, University of South Florida
#  http://www2.sas.com/proceedings/sugi24/Posters/p238-24.pdf
#
consistent.estimate.cliffs.d.variance <- function(sample1, sample2) {
  n1 <- length(sample1)
  n2 <- length(sample2)

  dm <- dominance_matrix(sample1, sample2)

  cd <- calc.cliffs.d(sample1, sample2)

  # Calc Sdi2
  rmeans <- rowMeans(dm)
  Sdi2 = sum(sapply(rmeans, function(di) ((di-cd)^2))) / (n1 - 1)

  # Calc Sdj2
  cmeans <- colMeans(dm)
  Sdj2 = sum(sapply(cmeans, function(dj) ((dj-cd)^2))) / (n2 - 1)

  # Calc Sdij2
  diff2m <- apply(dm, 1:2, function(dij) ((dij - cd)^2))
  dim(diff2m) <- NULL
  Sdij2 <- sum(diff2m) / ((n1 -1) * (n2 - 1))
  
  # Calc the consistent estimate Sdc2
  Sdc2 <- ( ((n2 - 1) * Sdi2) + ((n1 - 1) * Sdj2) + Sdij2 ) / (n1 * n2)
  Sdc2
}

# Z statistic for Cliff's d using an estimate of the variance.
z.statistic.cliffs.d <- function(d, var) {
  d / sqrt(var)
}

# Confidence interval for Cliff's d using the asymptotic
# interval calculation described in the Hogarty and Kromrey paper.
confidence.interval.for.cliffs.d <- function(d, sdc2, alpha = 0.05) {
  Zahalf <- qnorm(alpha / 2)
  Zahalf2 <- Zahalf^2
  denominator <- 1 - d^2 + Zahalf2*sdc2

  sdc = sqrt(sdc2)
  delta <- Zahalf * sdc * sqrt( (1-d^2)^2 + Zahalf2*sdc2 )

  lower <- (d - d^3 - delta) / denominator
  higher <- (d - d^3 + delta) / denominator

  sort(c(lower, higher))
}

# The default cliffs.d function packages the d value together with its
# variance estimation and confidence intervals.
cliffs.d <- function(sample1, sample2) UseMethod("cliffs.d")
cliffs.d.default <- function(sample1, sample2) {
  res <- list()
  res$d <- calc.cliffs.d(sample1, sample2)

  res$var.d <- consistent.estimate.cliffs.d.variance(sample1, sample2)
  res$z.consistent <- z.statistic.cliffs.d(res$d, res$var.d)
  res$p.value.consistent <- 2 * (1 - pnorm(abs(res$z.consistent)))

  res$confidence.0.95 <- confidence.interval.for.cliffs.d(res$d, res$var.d, 0.05)
  res$confidence.0.99 <- confidence.interval.for.cliffs.d(res$d, res$var.d, 0.01)

  # Significant if 0 is not in the confidence interval, i.e. if both  are either negative
  # or positive, i.e. if sum of the sign indicators are either -2 or 2. 
  s95 <- sign(res$confidence.0.95)
  if(abs(sum(s95)) == 2) {
    res$different.at.0.05 <- "SIGNIFICANT at alpha = 0.05 level"
  } else {
    res$different.at.0.05 <- "NOT SIGNIFICANT at the alpha = 0.05 level"
  }

  s99 <- sign(res$confidence.0.99)
  if(abs(sum(s99)) == 2) {
    res$different.at.0.01 <- "SIGNIFICANT at alpha = 0.01 level"
  } else {
    res$different.at.0.01 <- "NOT SIGNIFICANT at the alpha = 0.01 level"
  }

  class(res) <- "cliffs.d"
  res
}

print.cliffs.d <- function(res, ...) {
  cat("\n Cliff's d statistic, i.e. the measure of stochastic difference\n\n")

  cat("d = ")
  cat(sprintf("%.3f\n\n", res$d))

  cat("Variance of d = ")
  cat(sprintf("%.3f (with the consistent estimate of variance)\n\n", res$var.d))
  # Not sure of the calc of p-value since it can differ from the result based on confidence intervals below. Wait with this for now.
  #cat(sprintf("Z = %.3f, p-value = %.4f (for two-tailed test of hypothesis that difference == 0)\n\n", res$z.consistent, res$p.value.consistent))

  cat("95% confidence interval for d = [")
  cat(sprintf("%.3f, %.3f]\n", res$confidence.0.95[1], res$confidence.0.95[2]))
  cat(" Difference is ")
  cat(res$different.at.0.05)
  cat("\n\n")

  cat("99% confidence interval for d = [")
  cat(sprintf("%.3f, %.3f]\n", res$confidence.0.99[1], res$confidence.0.99[2]))
  cat(" Difference is ")
  cat(res$different.at.0.01)
  cat("\n")
}
