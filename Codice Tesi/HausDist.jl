#=
Function che calcola la distanza di Hausdorff tra due insiemi Set1 e Set2. Va precisato che Set1 è composto da un solo punto,
quindi la distanza di Hausdorff tra due insiemi dati in input sarà il valore minimo del vettore delle distanze contenente 
le distanze tra il singolo punto in Set1 ed i punti in Set2.
=#
function HausDist(Set1,Set2)
	Distances_Cloud = DistanceMatrix_inf(Set1,Set2);
	maxValue1 = maximum(minimum(Distances_Cloud,dims=1));
	maxValue2 = maximum(minimum(Distances_Cloud',dims=1));
	d = minimum([maxValue1 maxValue2]); #maximum([maxValue1 maxValue2]);
	return d
end