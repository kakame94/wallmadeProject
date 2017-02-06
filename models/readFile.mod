 using CPLEX ; 
 
 main {
	var pathSource = "../data/data.txt";
	var pathDest = "../data/data.dat";

	// Read from file function, we called readLineByLine to read the source file, then we write
	// in the destination file which is the ".dat" 
	// readLineByline return a String 	
	function readWriteFile(pathSource,pathDest){
		var fileIn = new IloOplInputFile();
		var fileOut = new IloOplOutputFile(pathDest,false);// here it's false cause we don't need to overwrite the file
		fileIn.open(pathSource);
		fileOut.writeln(readLineByLine(fileIn)); // we call our fonction which generate a big string.
		fileIn.close();
		fileOut.close();
		writeln("Reading from file done");
	}
     
    // function generating meeting model for further information check in the info.txt 
     function generateReunion(tab){
         if(tab.length > 0){
            var compositionReunion = "Reunion = { \n";
            for(var i = 0; i<tab.length;i++){
                var tabS = tab[i].split(" ");
                compositionReunion = compositionReunion + "<"+tabS[1]+","+tabS[2];
                var s =",[";
                writeln(tabS.length);
                for(var j = 3; j<tabS.length;j++ ){
                    if(j == tabS.length-1)
                        s=s+tabS[j];
                    else 
                        s=s+tabS[j]+",";
                }
                s=s+"]";
                compositionReunion = compositionReunion + s + ">\n,";
            }
		compositionReunion = compositionReunion.substring(0,compositionReunion.length-1);
             return compositionReunion + "};\n";
        }
        else
            return "";
        
    }
     // function generating unvailable assosiate, model further information in the info.txt 
    function generateIndispo(tab){
        if(tab.length > 0 ){
            var compositionIndispo  = "indispo = { \n";
             for(var i = 0; i<tab.length;i++){
                var tabS = tab[i].split(" ");
                compositionIndispo = compositionIndispo + "<"+tabS[1]+","+tabS[2];
                compositionIndispo = compositionIndispo + ","+tabS[3]+".."+tabS[4]+">\n,";
        }
	compositionIndispo = compositionIndispo.substring(0,compositionIndispo.length-1);
	compositionIndispo = compositionIndispo + "};\n";
            return compositionIndispo;
        }
        else return "";
    }
    
     // function generating scheduling model further information in the info.txt 
    function generatePrecede(tab){
        if(tab.length > 0 ){
            var compositionIndispo  = "precede = { \n";
             for(var i = 0; i<tab.length;i++){
                var tabS = tab[i].split(" ");
                compositionIndispo = compositionIndispo + "<"+tabS[1]+","+tabS[2]+">\n,";
        }
	    compositionIndispo = compositionIndispo.substring(0,compositionIndispo.length-1);        
	    compositionIndispo = compositionIndispo + "};\n";
            return compositionIndispo;
        }
        else return "";
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
		//plages
		var tablePlages = new Array();
		//reunion	
		var tableReunion = new Array();
		//indispo	
		var tableIndispo = new Array();
		//precede
		var tablePrecede = new Array();

		for (var i=0;i<table.length ;i++){
			if (table[i].indexOf("jours") >= 0 )
				tableJours[tableJours.length]=table[i];		
			else if (table[i].indexOf("plages") >= 0)
				tablePlages[tablePlages.length]=table[i];
			else if (table[i].indexOf("reunion") >= 0)
                tableReunion[tableReunion.length]=table[i];
			else if (table[i].indexOf("indispo") >= 0)
				tableIndispo[tableIndispo.length]=table[i];
			else if (table[i].indexOf("precede") >= 0)
				tablePrecede[tablePrecede.length]=table[i];
			else 
				writeln("Error on line", i);		
		}
			
	var returnedString="";

        if(tableJours.length > 1){
            writeln("Problem we must have only one line named jours !!!");
        }
        else {
            var a = tableJours[0];
		a = a.split(" ");
		a = a[1];
		writeln(a);
            returnedString=returnedString+"jours = "+a+";\n";
		writeln(returnedString);      
	  }
            
		if(tablePlages.length > 1){
            writeln("Problem we must have only one line named plages !!!");
        }
        else {
            var a = tablePlages[0].split(" ");
            a = a[1];
            writeln(a);
            returnedString=returnedString+"plages = "+a+";\n";
        }	
        
        returnedString = returnedString + generateReunion(tableReunion);
        returnedString = returnedString + generateIndispo(tableIndispo);
        returnedString = returnedString + generatePrecede(tablePrecede);

	return returnedString;
	}
readWriteFile(pathSource,pathDest);
}
