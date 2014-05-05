function parse_dataset_from_string(str){
  // Split then parse to float. Might return NaN for non-number strings.
  var values = str.split(/\s*(?:,|;|\s+)\s*/).map(parseFloat);

  // Filter so NaN is not returned.
  var result = _.filter(values, function(n){ return !isNaN(n)});

  return( result );
}

// Comparing objects for equality in Javascript is quite complex but this
// should take care of it even if recursive hash-like objects etc.
function isEqualRecursiveCompare(obj, reference){
  if(obj === reference) return true;

  if(obj.constructor !== reference.constructor) return false;

  if(obj instanceof Array){

    if(obj.length !== reference.length) return false;
    for(var i=0, len=obj.length; i<len; i++){
      if(typeof obj[i] == "object" && typeof reference[j] == "object"){
        if(!isEqualRecursiveCompare(obj[i], reference[i])) return false;
      } else if(obj[i] !== reference[i]) {return false;}
    }

  } else {

    var objListCounter = 0;
    var refListCounter = 0;
    for(var i in obj){
      objListCounter++;
      if(typeof obj[i] == "object" && typeof reference[i] == "object"){
        if(!isEqualRecursiveCompare(obj[i], reference[i])) return false;
      }
      else if(obj[i] !== reference[i]) return false;
    }
    for(var i in reference) refListCounter++;
    if(objListCounter !== refListCounter) return false;

  }

  return true; //Every object and array is equal
}

