// Parse the sampling strings on the format:
//   Normal(20, 10) - 10 samples       => rnorm(10, mean = 20, sd = 10)
//   Uniform(10, 30) - 20 samples      => runif(20, min = 10, max = 30)
// and return an array with R function call name and arguments to produce that sample.
function parseSamplingDescriptionToRCode(description) {
	var match = /\s*([A-Za-z]+)\((\d+)\s*,\s*(\d+)\)\s+-\s+(\d+)\s+samples/i.exec(description);

	if(match[1].toLowerCase() == "uniform") {

		return( ["runif_sample", {"n": parseInt(match[4]), "min": parseFloat(match[2]), "max": parseFloat(match[3])}] );

	} else if (match[1].toLowerCase() == "normal") {

		return( ["rnorm_sample", {"n": parseInt(match[4]), "mean": parseFloat(match[2]), "sd": parseFloat(match[3])}] );

	}

	return "unknown";
}
