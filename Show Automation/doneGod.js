var watchdog = new SQLite;
var result = new SQLResult;

function opendb(x) {
    watchdog.open(x,1); //open a file-based DB
}

function closedb() {
	watchdog.close();
}

function exec(arg) {
	// execute the SQL statement in arg, returning results in the 'result' object
	watchdog.exec(arg, result);

	// access information about the returned records by calling functions on the result object
	outputResult();
}

function outputResult() {
    var numfields = result.numfields();
    var numrecords = result.numrecords();
    var fieldnames = new Array(numfields);
    var values = new Array(numfields);

	for(var i=0; i<numrecords; i++){
	    for(var j=0; j<numfields; j++) {
		outlet(0, result.fieldname(j) + " \"" + result.value(j, i) + "\"");
	    }
	    outlet(0, i);
	}
	outlet(0, "done");
}