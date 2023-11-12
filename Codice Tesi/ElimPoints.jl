#=
Function che elimina dal Cloud di punti in input.
=#
function ElimPoints(Cloud,tol)
	Distances_Cloud = DistanceMatrix(Cloud,Cloud);
	maxValue = maximum(Distances_Cloud)+1;
	indexArray = findall(x -> x == 0, Distances_Cloud);
	for i = 1:length(indexArray)
		Distances_Cloud[indexArray[i]] = maxValue;
	end
	minDist = minimum(Distances_Cloud);
	minDist = minDist/2;
	indElim = [];
	while minDist < tol #Eliminazione dei punti troppo vicini
		indCol = findmin(Distances_Cloud); #Viene salvato il valore minimo e la sua posizione nella matrice
		minDist = indCol[1];
		minDist = minDist/2;
		push!(indElim,indCol[2][2]);
		Distances_Cloud[indCol[2][2],:] .= maxValue; #La matrice viene aggiornata affinché il ciclo while termini
		Distances_Cloud[:,indCol[2][2]] .= maxValue;
	end
	indElim = sort(indElim);
	newCloud = Cloud;
	newCloud = newCloud[setdiff(1:end,indElim),:]; #Creazione nuovo Cloud
	return newCloud, indElim
end

function ElimPoints_PAR(Cloud,tol)
	Distances_Cloud = DistanceMatrix_PAR(Cloud,Cloud);
	maxValue = maximum(Distances_Cloud)+1;
	indexArray = findall(x -> x == 0, Distances_Cloud);
	for i = 1:length(indexArray)
		Distances_Cloud[indexArray[i]] = maxValue;
	end
	minDist = minimum(Distances_Cloud);
	minDist = minDist/2;
	indElim = [];
	while minDist < tol
		indCol = findmin(Distances_Cloud);
		minDist = indCol[1];
		minDist = minDist/2;
		push!(indElim,indCol[2][2]);
		Distances_Cloud[indCol[2][2],:] .= maxValue;
		Distances_Cloud[:,indCol[2][2]] .= maxValue;
	end
	indElim = sort(indElim);
	newCloud = Cloud;
	newCloud = newCloud[setdiff(1:end,indElim),:];
	return newCloud, indElim
end