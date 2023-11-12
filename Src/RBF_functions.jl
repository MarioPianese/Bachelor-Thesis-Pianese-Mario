#=
Function che calcola la RBF Gaussiana (con parametro sigma) su ogni elemento della matrice Mat in input. Restituisce il risultato in A.
=#
function Gaussian(Mat,sigma)
	Mat = Mat.^2/(2*sigma^2);
	A = exp.(-Mat);
	A = A/(sigma*sqrt(2*pi));
	return A
end

function Gaussian_PAR(Mat,sigma)
	M, N = size(Mat);
	A = zeros(M,N);
	Threads.@threads :dynamic for i = 1:M #Associo ogni riga di Mat e A ad un solo thread.
		for j = 1:N
			Mat[i,j] = Mat[i,j]^2;
			Mat[i,j] = Mat[i,j]/(2*sigma^2);
			A[i,j] = exp(-Mat[i,j]);
			A[i,j] = A[i,j]/(sigma*sqrt(2*pi));
		end
	end
	return A
end