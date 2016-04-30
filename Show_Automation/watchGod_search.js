var watchdog = new SQLite;
var result = new SQLResult;
inlets = 1
outlets = 2

function opendb(x) {
    watchdog.open(x,1); //open a file-based DB
}

function closedb() {
	watchdog.close();
}

function exec(arg) {
	var tmp_string = "SELECT ID_NAME, DESCRIPTION, DEVICE_TYPE FROM devices where (((DESCRIPTION LIKE '%" + arg + "%')" + " OR (DEVICE_NAME LIKE '%" + arg + "%')" + "OR (ID_NAME LIKE '%" + arg + "%'))" + " AND DEVICE_TYPE NOT LIKE 'Software')";
	post(tmp_string);
	// execute the SQL statement in arg, returning results in the 'result' object
	watchdog.exec(tmp_string, result);

	// access information about the returned records by calling functions on the result object
	outputResult();
}

function outputResult() {
    var numfields = result.numfields();
    var numrecords = result.numrecords();
    var fieldnames = new Array(numfields);
    var values = new Array(numfields);

	if (numrecords == 1) {
	/* one result goes out the left outlet */
		for(var i=0; i<numrecords; i++){
	    	for(var j=0; j<numfields; j++) {
				outlet(0, result.fieldname(j) + " \"" + result.value(j, i) + "\"");
	    	}
	    	outlet(0, i);
		}
	} else if (numrecords > 1) {
	/* multiple results go out the right outlet */
		for(var i=0; i<numrecords; i++){
	    	for(var j=0; j<numfields; j++) {
				outlet(1, result.fieldname(j) + " \"" + result.value(j, i) + "\"");
	    	}
	    	outlet(1, i);
		}	
	}
}