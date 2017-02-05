 using CPLEX ; 
 
 main {
	var pathSource = "../data/data.txt";
	var pathDest = "../data/data.dat";

	// Read from file function, we called readLineByLine to read the source file, then we write
	// in the destination file which is the ".dat" 
	// readLineByline return a String 	
	function readWriteFile(pathSource,pathDest){
		var fileIn = new IloOplInputFile();
		var fileOut = new IloOplOutputFile(pathDest,true);
		fileIn.open(pathSource);
		fileOut.writeln(readLineByLine(file));
		fileIn.close();
		fileOut.close();
		writeln("Reading from file done");
	}

	function readLineByLine(file){
		// creating a table to stock all the line readed in the input file	
		var table = new Array();
		// initialize indexing var for ou table	
		var i = 0 ; 	
		while(!file.eof){
			table[i] = file.readline();
			i++;	
		}	
		writeln(table);
		// now we have all the line of our input file 
		// lets compose our string
		var tableJours = new Array();
		var joursTest = new RegExp("jours");
		//plages
		var tablePlages = new Array();
		var plagesTest = new RegExp("plages");
		//reunion	
		var tableReunion = new Array();
		var reunionTest = new RegExp("reunion");
		//indispo	
		var tableIndispo = new Array();
		var indispoTest = new RegExp("indispo");
		//precede
		var tablePrecede = new Array();
		var joursTest = new RegExp("precede");

		for (var i=0;i<table.length ;i++){
			if (joursTest.test(table[i]))
				tableJours[tableJours.length()]=table[i];
			else if (plagesTest.test(table[i]))
				tablePlages[tablePlages.length()]=table[i];
			else if (reunionTest.test(table[i]))
				tableReunion[tableReunion.length()]=table[i];
			else if (indispoTest.test(table[i]))
				tableIndispo[tableIndispo.length()]=table[i];
			else if (joursTest.test(table[i]))
				tablePrecede[tablePrecede.length()]=table[i];
			else 
				writeln("Error on line", i);		
		}
			
		var returnedString="";
							
	}
}
