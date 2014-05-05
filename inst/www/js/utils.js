function numbersToString(numbers, signifDigits, numbersPerLine) {
	signifDigits = signifDigits || 3;
	numbersPerLine = numbersPerLine || 10;

	var to_signif = function(n) {return n.toPrecision(signifDigits)};
	var strings = numbers.map(to_signif);

	var line = [];

	for(i=0; i < strings.length; i++) {
		if(i != 0 && i % numbersPerLine == 0) {
			line.push("\n");
			line.push(strings[i]);
		} else if(i != 0) {
			line.push(", ");
			line.push(strings[i]);
		} else {
			line.push(strings[i]);
		}
	}

	return( line.join("") );
}