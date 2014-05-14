// Functions for dynamically adding Bootstrap tables.

function clear_table(tableId) {
	var table = document.getElementById(tableId);
	table.innerHTML = "";	
}

function append_row(tableId, row, partTag, itemTag) {
	var elem = $("#" + tableId + ' > ' + partTag + ':last');
	$.each(header, function(i,item){
		elem.appendChild('<'+itemTag+'>'+item+'</'+itemTag+'>');
	});	
}

function fill_table_from_data(tableId, header, rows) {
	clear_table(tableId);
	var table = document.getElementById(tableId);

	table.appendChild("<thead><tr></tr></thead>");
	append_row(tableId, header, 'thead', 'th');

	table.appendChild("<tbody></tbody>");
	$.each(rows, function(i,row){
		$("#" + tableId + ' > tbody').append("<tr></tr>")
		append_row(tableId, row, 'tbody', 'th');
	});
}

function add_table_last_in_div(divId, tableId, headerNames, rows, className) {
	// Set default arguments
	className = className || "table table-striped table-bordered table-condensed table-hovered"

	// Create table, thead and body
	var tbl = document.createElement('table');
	tbl.style.width = '100%';
	tbl.className = className;
	var tbdy = document.createElement('tbody');

	// Add thead with its header columns on a row
	var thd = document.createElement('thead');
	var thrw = document.createElement('tr'); // creating new row in thead
	for(column in headerNames) {
		var th = document.createElement('th');
		th.appendChild(document.createTextNode(columns));
		thrw.appendChild(th);
	}
	thd.appendChild(thrw);
	tbl.appendChild(thd);

	// Add tbody with its rows
	var tbdy = document.createElement('tbody');
	for(row in rows) {
		var tbrw = document.createElement('tr');
		for(item in row) {
			var th = document.createElement('th');
			th.appendChild(document.createTextNode(item));
			thrw.appendChild(th);		
		}
	}

	


	for (index in rows) {
            var tr = document.createElement('tr'); // creating new row 
            var items = rows[index].split(delimiter);
            for (itemindex in items) {
            	var td = "";
            	if (index == 0) {
            		td = document.createElement('th');
            	} else {
            		td = document.createElement('td');
            	}

                td.appendChild(document.createTextNode(items[itemindex])); // creating new cell 
                tr.appendChild(td); // add to current tr
            }

            tbdy.appendChild(tr); // add new row (tr) to table 
        }
        tbl.appendChild(tbdy);}
