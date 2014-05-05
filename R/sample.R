# We added these proxy functions since we did not find a way to call out from the context of the 
# ClearStats package using ocpu.rpc. Should not be needed long-term.

runif_sample <- function(n, min, max) {
	return( runif(n = n, min = min, max = max) );
}

rnorm_sample <- function(n, mean, sd) {
	return( rnorm(n = n, mean = mean, sd = sd) );
}