#=
Function che crea le versioni modificate ed estese del Cloud di punti da interpolare dato in input.
Vengono ritornate tutte le versioni del Cloud create ed inoltre vengono ritornati gli indici dei punti eliminati dai
Cloud durante l'esecuzione.
=#
function CreateCloud(Cloud,Normals,tol,alpha)
	#Riordino del Cloud e delle Normals in maniera randomica in modo da aumentare la probabilità di un miglior risultato
	Cloud = Cloud[shuffle(1:end),:];
	Normals = Normals[shuffle(1:end),:];
	Cloud2, Ind_Elim1 = ElimPoints(Cloud,tol/alpha); #Eliminazione dei punti troppo vicini
	Normals2 = Normals;
	Normals2 = Normals2[setdiff(1:end,Ind_Elim1),:]; #Aggiornamento delle Normali
	distCloud2, minDists2 = Cloud_Dist(Cloud2);
	Cloud3 = AddPoints(Cloud2,minDists2,Normals2,1.2*+alpha); #Estensione del Cloud
	n3 = size(Cloud3,1);
	n = n3/3;
	Distances_Cloud = DistanceMatrix(Cloud3,Cloud3);
	maxValue = maximum(Distances_Cloud)+1;
	indexArray = findall(x -> x == 0, Distances_Cloud);
	for i = 1:length(indexArray)
		Distances_Cloud[indexArray[i]] = maxValue;
	end
	minDist = minimum(Distances_Cloud);
	minDist = minDist/2;
	Ind_Elim3 = [];
	while minDist < 1.3*tol #Eliminazione dei punti troppo vicini nel Cloud esteso
		indCol = findmin(Distances_Cloud[:,Int(n+1):end]); #Viene salvato il valore minimo e la sua posizione nella matrice
		minDist = indCol[1];
		minDist = minDist/2;
		push!(Ind_Elim3,Int(indCol[2][2]+n));
		Distances_Cloud[Int(indCol[2][2]+n),:] .= maxValue; #La matrice viene aggiornata affinché il ciclo while termini
		Distances_Cloud[:,Int(indCol[2][2]+n)] .= maxValue;
	end
	Ind_Elim3 = sort(Ind_Elim3);
	Cloud4 = Cloud3;
	Cloud4 = Cloud4[setdiff(1:end,Ind_Elim3),:]; #Creazione nuovo Cloud
	return Cloud4, Cloud3, Cloud2, Ind_Elim1, Ind_Elim3
end

function CreateCloud_PAR(Cloud,Normals,tol,alpha)
	Cloud = Cloud[shuffle(1:end),:];
	Normals = Normals[shuffle(1:end),:];
	Cloud2, Ind_Elim1 = ElimPoints_PAR(Cloud,tol/alpha);
	Normals2 = Normals;
	Normals2 = Normals2[setdiff(1:end,Ind_Elim1),:];
	distCloud2, minDists2 = Cloud_Dist_PAR(Cloud2);
	Cloud3 = AddPoints(Cloud2,minDists2,Normals2,1.2*+alpha);
	n3 = size(Cloud3,1);
	n = n3/3;
	Distances_Cloud = DistanceMatrix_PAR(Cloud3,Cloud3);
	maxValue = maximum(Distances_Cloud)+1;
	indexArray = findall(x -> x == 0, Distances_Cloud);
	for i = 1:length(indexArray)
		Distances_Cloud[indexArray[i]] = maxValue;
	end
	minDist = minimum(Distances_Cloud);
	minDist = minDist/2;
	Ind_Elim3 = [];
	while minDist < 1.3*tol
		indCol = findmin(Distances_Cloud[:,Int(n+1):end]);
		minDist = indCol[1];
		minDist = minDist/2;
		push!(Ind_Elim3,Int(indCol[2][2]+n));
		Distances_Cloud[Int(indCol[2][2]+n),:] .= maxValue;
		Distances_Cloud[:,Int(indCol[2][2]+n)] .= maxValue;
	end
	Ind_Elim3 = sort(Ind_Elim3);
	Cloud4 = Cloud3;
	Cloud4 = Cloud4[setdiff(1:end,Ind_Elim3),:];
	return Cloud4, Cloud3, Cloud2, Ind_Elim1, Ind_Elim3
end