#=
Function che calcola l'interpolante Pf valutato sulla griglia csi in input, utilizzando il metodo del Gradiente Coniugato (cg()).
=#
function CalcInterpolant(Cloud,csi,b,sigma)
	#Costruzione della Matrice A
	Distances_Cloud = DistanceMatrix(Cloud,Cloud);
	A = Gaussian(Distances_Cloud,sigma);
	#Risoluzione del sistema Ac=b
	c = cg(A,b);
	#Costruzione della Matrice B
	Distances_csi = DistanceMatrix(csi,Cloud);
	B = Gaussian(Distances_csi,sigma);
	#Calcolo dell'interpolante
	Pf = B*c;
	return Pf
end

function CalcInterpolant_PAR(Cloud,csi,b,sigma)
	Distances_Cloud = DistanceMatrix_PAR(Cloud,Cloud);
	A = Gaussian_PAR(Distances_Cloud,sigma);
	c = cg(A,b);
	Distances_csi = DistanceMatrix_PAR(csi,Cloud);
	B = Gaussian_PAR(Distances_csi,sigma);
	Pf = B*c;
	return Pf
end

function CalcInterpolant_PAR2(Cloud,csi,b,sigma)
	Distances_Cloud = DistanceMatrix_PAR(Cloud,Cloud);
	A = Gaussian_PAR(Distances_Cloud,sigma);
	c = cg(A,b);
	Distances_csi = DistanceMatrix_PAR(csi,Cloud);
	B = Gaussian_PAR(Distances_csi,sigma);
	M, N = size(B);
	Pf = zeros(M,1);
	Threads.@threads :dynamic for i = 1:M #Ogni elemento di Pf è calcolato da un solo Thread, no RC
		for j = 1:N
			Pf[i] += B[i,j]*c[j];
		end
	end
	#Pf = B*c;
	return Pf
end