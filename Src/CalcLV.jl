#=
Function che calcola e ritorna il valore lv che indica la grandezza della griglia Grid calcolata in seguito.
=#
function CalcLV(Cloud,M,hmax,beta)
	maxCoor, minCoor = MinMaxCoordinates(Cloud);
	deltaX = maxCoor[1] - minCoor[1]; deltaY = maxCoor[2] - minCoor[2]; deltaZ = maxCoor[3] - minCoor[3];
	L = maximum([deltaX,deltaY,deltaZ]);
	LV = trunc((M*L)/(2*hmax*beta));
	return LV
end