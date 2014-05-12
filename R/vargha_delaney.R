#
# Vargha-Delanye non-parametric effect size.
# Copyright (c) Robert Feldt, 2010-2014
# robert.feldt@gmail.com
# 
# Incorporated into ClearStats 2014-05-12 based on nonparametric_effect_sizes.R
#

# Vargha and Delaney's A statistic, i.e. the measure of stochastic superiority
#   P(X1 > X2) + 0.5 * P(X1 == X2)
# where X1 and X2 can be discrete or continuous as long as they are at least
# ordinally scaled. This is the main function which calculates both a, its 
# interpretation and confidence intervals.
#
# From:
#  András Vargha and Harold D. Delaney,
#  A Critique and Improvement of the CL Common Language Effect Size Statistics of McGraw and Wong 
#  JOURNAL OF EDUCATIONAL AND BEHAVIORAL STATISTICS 2000 25: 101 DOI: 10.3102/10769986025002101
#  The online version of this article can be found at: http://jeb.sagepub.com/content/25/2/101
#
# The paper gives the following examples of interpreting A:
#   A ~ 0.56 => Small effect size (i.e. small superiority of X1 over X2)
#   A ~ 0.64 => Medium effect size (i.e. medium superiority of X1 over X2)
#   A ~ 0.71 => Large effect size (i.e. large superiority of X1 over X2)
#
a.statistic <- function(sample1, sample2) UseMethod("a.statistic")
a.statistic.default <- function(sample1, sample2) {
  analysis <- list()
  analysis$a <- calc.a.statistic(sample1, sample2)
  analysis$interpretation <- interpreting.a.statistic(analysis$a)
  analysis$call <- match.call()
  
  #indicate which one is superior
  if(analysis$a > 0.5) {
    analysis$superior <- "sample1"
  } else if(analysis$a < 0.5) {
    analysis$superior <- "sample2"
  } else {
    analysis$superior <- "NONE is superior"
  }

  # According to page 19 of the Vargha and Delayne paper we can obtain a CI for the
  # A statistic by transforming the CI for cliff's d using the same transform used
  # for the statistic itself.
  d <- calc.cliffs.d(sample1, sample2)
  var.d <- consistent.estimate.cliffs.d.variance(sample1, sample2)
  d.confidence.0.95 <- confidence.interval.for.cliffs.d(d, var.d, 0.05)
  d.confidence.0.99 <- confidence.interval.for.cliffs.d(d, var.d, 0.01)
  a95 <- analysis$confidence.0.95 <- (d.confidence.0.95+1)/2;
  a99 <- analysis$confidence.0.99 <- (d.confidence.0.99+1)/2;

  # Significant if 0.5 is not in the confidence interval, i.e. if both are
  # either larger than or smaller than 0.5.
  if(all(a95 > 0.5) || all(a95 < 0.5)) {
	# We mark this experimental since it is not explicitly in the V&D paper but should be right
    analysis$different.at.0.05 <- "SIGNIFICANT at alpha = 0.05 level (Note: EXPERIMENTAL)"
  } else {
	# We mark this experimental since it is not explicitly in the V&D paper but should be right
    analysis$different.at.0.05 <- "NOT SIGNIFICANT at the alpha = 0.05 level (Note: EXPERIMENTAL)"
  }

  # Significant if 0.5 is not in the confidence interval, i.e. if both are
  # either larger than or smaller than 0.5.
  if(all(a99 > 0.5) || all(a99 < 0.5)) {
	# We mark this experimental since it is not explicitly in the V&D paper but should be right
    analysis$different.at.0.01 <- "SIGNIFICANT at alpha = 0.01 level (Note: EXPERIMENTAL)"
  } else {
	# We mark this experimental since it is not explicitly in the V&D paper but should be right
    analysis$different.at.0.01 <- "NOT SIGNIFICANT at the alpha = 0.01 level (Note: EXPERIMENTAL)"
  }

  class(analysis) <- "a.statistic"
  analysis
}

print.a.statistic <- function(a, ...) {
  cat("\n Vargha and Delaney's A statistic, i.e. the measure of stochastic superiority\n\n")

  cat("Call:\n")
  print(a$call)
  cat("\n")
  
  cat("A statistic = ")
  cat(a$a)
  cat("\n")

  cat(sprintf(" i.e. the probability that a value from sample1 is larger than a value from sample2 is %.2f%%\n\n", 100.0 * a$a))

  cat(sprintf("95%% confidence interval for A = [%.3f, %.3f]\n", a$confidence.0.95[1], a$confidence.0.95[2]))
  cat(sprintf(" Difference is %s\n\n", a$different.at.0.05))

  cat(sprintf("99%% confidence interval for A = [%.3f, %.3f]\n", a$confidence.0.99[1], a$confidence.0.99[2]))
  cat(sprintf(" Difference is %s\n\n", a$different.at.0.01))

  cat("Superior: ")
  cat(a$superior)
  cat("\n")

  cat("Effect size: ")
  cat(a$interpretation)
  cat("\n")
}

# Just the calc of the a statistic itself.
calc.a.statistic <- function(sample1, sample2) {
  cd <- calc.cliffs.d(sample1, sample2)
  (cd + 1) / 2
}

interpreting.a.statistic <- function(a) {
  # Give an indication of the interpretation based on the table from Vargha and Delaney's paper.
  dist <- abs(a - 0.5);
  if(dist == 0.0) {
    "NO effect"
  } else if(dist <= 0.10) {
    "Small"
  } else if(dist <= 0.17) {
    "Medium"
  } else {
    "Large"
  }
}
