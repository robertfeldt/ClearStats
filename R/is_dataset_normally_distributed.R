library(nortest) # for ad.test

interpret.p.value <- function(pvalue, alpha, testDesc, hypothesisDesc) {
  pv <- signif(pvalue, 2)

  if(pvalue < alpha) {
    paste(testDesc, " rejected (p-value = ", pv,
        " < ", alpha, ") the hypothesis ", hypothesisDesc, sep = "")
    } else {
      paste(testDesc, " could NOT reject (p-value = ", pv,
        " >= ", alpha, ") the hypothesis ", hypothesisDesc, sep = "")
    }
}

#
# We should simplify and generalize the code below. Just copy-paste messing-around for now...
#

# Shapiro-Wilk test for normality. Wrapped to explain its workings...
shapiro.wilk.normality.test <- function(x, alpha = 0.05) {
  ref1 = "Shapiro, S. S.; Wilk, M. B. (1965). \"An analysis of variance test for normality (complete samples)\". Biometrika 52 (3–4): 591–611. doi:10.1093/biomet/52.3-4.591."
  desc = "Shapiro-Wilk test for normality"
  result <- list(refs = c(ref1))

  if(length(x) < 3) {

    result$interpretation <- paste(desc, "could NOT be used; there were fewer than 3 data points")
    result$apply <- FALSE

  } else if(length(x) > 5000) {

    result$interpretation <- paste(desc, "could NOT be used; there were more than 5000 data points")
    result$apply <- FALSE

  } else {

    result$apply <- TRUE
    r <- shapiro.test(x)
    result$interpretation <- interpret.p.value(r$p.value, alpha, desc, "that the data is normally distributed")
    
  }

  return(result)
}


# Andersson-Darling test for normality. Wrapped to explain its workings...
anderson.darling.normality.test <- function(x, alpha = 0.05) {
  ref1 = " Anderson, T.W. and Darling, D.A. (1954). \"A Test of Goodness-of-Fit\". Journal of the American Statistical Association 49: 765–769."
  desc = "Anderson-Darling test for normality"
  result <- list(refs = c(ref1))

  if(length(x) <= 7) {

    result$interpretation <- paste(desc, "could NOT be used; there were fewer than 8 data points")
    result$apply <- FALSE

  } else {

    result$apply <- TRUE
    r <- ad.test(x)
    result$interpretation <- interpret.p.value(r$p.value, alpha, desc, "that the data is normally distributed")
    
  }

  return(result)
}

# Cramer-Mises test for normality. Wrapped to explain its workings...
cramer.mises.normality.test <- function(x, alpha = 0.05) {
  ref1 = "H. Cramér, On the composition of elementary errors, Scandinavian Actuarial Journal, 1928"
  ref2 = "R. E. von Mises, Wahrscheinlichkeit, Statistik und Wahrheit, Julius Springer, 1928"
  desc = "Cramer-von Mises test for normality"
  result <- list(refs = c(ref1, ref2))

  if(length(x) <= 7) {

    result$interpretation <- paste(desc, "could NOT be used; there were fewer than 8 data points")
    result$apply <- FALSE

  } else {

    result$apply <- TRUE
    r <- cvm.test(x)
    result$interpretation <- interpret.p.value(r$p.value, alpha, desc, "that the data is normally distributed")
    
  }

  return(result)
}

is_dataset_normally_distributed <- function(xStr, alpha = 0.05) {
  x <- parse_dataset_from_string(xStr);

  return(anderson.darling.normality.test(x, alpha));
}