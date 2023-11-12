#=
Function che ritorna le coordinate massime e minime del Cloud dato in input.
=#
function MinMaxCoordinates(Cloud)
	maxCoor = maximum(Cloud,dims=1);
	minCoor = minimum(Cloud,dims=1);
	return maxCoor, minCoor
end