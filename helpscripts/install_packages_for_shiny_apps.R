needed_packages = c(
  "shiny",
  "shinyAce",
  "ggplot2",
  "nortest"
)

install_if_missing = function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {

    install.packages(p, dependencies = TRUE)

  } else {

    cat(paste("Skipping already installed package:", p, "\n"))

  }
}

invisible(sapply(needed_packages, install_if_missing))