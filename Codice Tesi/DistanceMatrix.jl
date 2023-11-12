#=
Function che calcola la matrice delle distanze cDist tra due insiemi di punti in input Cloud1 e Cloud2
=#
function DistanceMatrix(Cloud1,Cloud2)
	M, s1 = size(Cloud1);
	N, s2 = size(Cloud2); #Si presuppone che tutti gli elementi di Cloud1 e Cloud2 abbiano lo stesso numero di componenti (3) e che quindi s1 == s2
	cDist = zeros(M,N);
	for i = 1:M, j = 1:N, d = 1:s1
		cDist[i,j] = cDist[i,j] + (Cloud2[j,d]-Cloud1[i,d])^2;
	end
	cDist = sqrt.(cDist);
	return cDist
end

function DistanceMatrix_PAR(Cloud1,Cloud2)
	M, s1 = size(Cloud1);
	N, s2 = size(Cloud2);
	cDist = zeros(M,N);
	Threads.@threads :dynamic for i = 1:M #Ogni riga è associata ad un solo thread
		for j = 1:N
			for d = 1:s1
				cDist[i,j] = cDist[i,j] + (Cloud2[j,d]-Cloud1[i,d])^2;
            end
        end
    end
	cDist = sqrt.(cDist);
	return cDist
end

function DistanceMatrix_inf(Cloud1,Cloud2)
	M, s1 = size(Cloud1);
	N, s2 = size(Cloud2);
	cDist = zeros(M,N);
	for i = 1:M, j = 1:N
		cDist[i,j] = norm(Cloud1[i,:]-Cloud2[j,:],Inf);
	end
	return cDist
end