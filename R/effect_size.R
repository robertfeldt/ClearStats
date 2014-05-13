library(orddom)

summary_effect_size <- function(a, b) {
  delta_gr(a, b)
}

vargha_delaney_effect_size <- function(a, b){
	all_results <- dmes(a, b)
	return(all_results$Ac)
}