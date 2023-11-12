#=
Function che calcola la matrice delle distanze ed il vettore delle distanze minime dato un Cloud di punti in input.
=#
function Cloud_Dist(Cloud)
	Distances_Cloud = DistanceMatrix(Cloud,Cloud);
	maxValue = maximum(Distances_Cloud); #Si cerca il valore massimo della matrice
	indexArray = findall(x -> x == 0, Distances_Cloud); #Si cercano i valori pari a 0 nella matrice e li si sostituiscono con il valore massimo
	for i = 1:length(indexArray)
		Distances_Cloud[indexArray[i]] = maxValue+1;
	end	
	minDists = minimum(Distances_Cloud,dims=2); #Si estraggono le distanze minime
	return Distances_Cloud, minDists
end

function Cloud_Dist_PAR(Cloud)
	Distances_Cloud = DistanceMatrix_PAR(Cloud,Cloud);
	maxValue = maximum(Distances_Cloud);
	indexArray = findall(x -> x == 0, Distances_Cloud);
	for i = 1:length(indexArray)
		Distances_Cloud[indexArray[i]] = maxValue+1;
	end	
	minDists = minimum(Distances_Cloud,dims=2);
	return Distances_Cloud, minDists
end